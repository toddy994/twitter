require "pry"
require "twitter"

class Follower
  def initialize(client)
    @client = client
  end

  def follow(user)
    @client.follow(user)
  end
end

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ""
  config.consumer_secret     = ""
  config.access_token        = ""
  config.access_token_secret = ""
end

follower = Follower.new(client)

def search_for_tweets_to(hashtag, client)
  client.search("##{hashtag}", count: 100)
end

ARGV.each do |hashtag|
  search_for_tweets_to(hashtag, client).each do |tweet|
    follower.follow(tweet.user)
    sleep 5
  end
end
