require "rails_helper"

RSpec.describe "Account APIs", type: :request do
	let(:user) { 
		FactoryBot.create(:user, 
			email: "test@example.com", 
			first_name: "jane", 
			last_name: "doe",
			twitter_handle: "janedoetweets"
		)
	}
	let(:user_timeline) {
		[
			{"id": 1, "text": "tweet1"}, 
			{"id": 2, "text": "tweet2"}, 
			{"id": 3, "text": "tweet3"}
		]
	}
	let!(:twitter_client_double) { instance_double(Twitter::REST::Client, user_timeline: user_timeline) }

	describe "GET /api/v1/account" do
		let(:params) { { max_results: 10 } }
 
		def fetch_tweets
			get '/api/v1/account', params: params
		end

		context "when user is signed in" do
			before do
				sign_in user
				allow(Twitter::REST::Client).to receive(:new).and_return(twitter_client_double)
			end

			it "fetches tweets" do
				fetch_tweets
				expect(response).to have_http_status(:ok)
				expect(response.body).to eq(user_timeline.to_json)
			end

			context "when there is an error with the Twitter Client" do
				before do
					allow(twitter_client_double).to receive(:user_timeline).and_raise(StandardError)
				end

				it "logs and returns an error" do
					expect(Rails.logger).to receive(:error).with('Could not retrieve tweets')
					fetch_tweets
					expect(response).to have_http_status(:service_unavailable)
					expect(JSON.parse(response.body)["error"]).to eq('StandardError')
				end
			end
		end

		context "when user is not signed in" do
			it "returns unauthorized" do
				fetch_tweets
				expect(response).to have_http_status(:unauthorized)
			end

			it "does not fetch tweets" do
				expect(Twitter::REST::Client).to_not receive(:new)
				fetch_tweets
			end
		end
	end
end