require 'json'
require 'twitter'


class Tokens
	attr_accessor :consumerKey, :consumerSecret, :accessToken, :accessSecret
	def getValues()
		file = File.read('tokens.json')
		data_hash = JSON.parse(file)

		@consumerKey = data_hash['keys']["Consumer Key (API Key)"]
		@consumerSecret = data_hash['keys']["Consumer Secret (API Secret)"]
		@accessToken = data_hash['keys']["Access Token"]
		@accessSecret = data_hash['keys']["Access Token Secret"]

		#print("Values have been collected and stored.\n")
	end
end

tokens = Tokens.new
tokens.getValues()

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = tokens.consumerKey
  config.consumer_secret     = tokens.consumerSecret
  config.access_token        = tokens.accessToken
  config.access_token_secret = tokens.accessSecret
end


#client.update("Share the love. Spread the peace. Be the happiness.")
client.followers.each do |f|
	print(f.to_s + "\n")
end

#print(client.user_timeline(0x00000002de2a90))
#print(client.status(342573720239484929))