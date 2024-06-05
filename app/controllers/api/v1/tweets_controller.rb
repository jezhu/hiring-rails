# class Api::V1::TweetsController < ApplicationController

# 	def show
# 		response = client.get('users/me')

# 		id = response["data"]["id"]
# 		results = params[:max_results] || 10
# 		client.get("lists/#{id}/tweets?max_results=#{results}")
# 	end

# 	private

# 	def client
# 		@client ||credentials= X::Client.new(
# 			api_key: Rails.application.credentials.twitter[:api_key],
# 			api_key_secret: Rails.application.credentials.twitter[:api_key_secret],
# 			access_token: Rails.application.credentials.twitter[:access_token],
# 			access_token_secret: Rails.application.credentials.twitter[:access_token_secret]
# 		)
# 	end
# end
