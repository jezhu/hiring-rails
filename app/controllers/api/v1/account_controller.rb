class Api::V1::AccountController < ApplicationController
  def show
    begin
      results = params[:max_results] || 10

      twitter_handle = current_user.twitter_handle

      # NOTE: did not get to test w/o api key and key secret and access token
      @tweets = client.user_timeline(twitter_handle, { count: results })
      render json: @tweets.to_json
    rescue => e
      Rails.logger.error("Could not retrieve tweets")
      render json: { error: e.message }, status: :service_unavailable
    end
  end

  def update
    @resource = UserActions::Update.call(user: current_user, params: permitted_params).resource
  end

  private

  def permitted_params
    params.require(:user).permit(:first_name, :last_name, :bio, :phone_number, :twitter_handle)
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.api_key = Rails.application.credentials.twitter[:api_key],
      config.api_key_secret = Rails.application.credentials.twitter[:api_key_secret],
      config.access_token = Rails.application.credentials.twitter[:access_token],
      config.access_token_secret = Rails.application.credentials.twitter[:access_token_secret]
    end
  end
end
