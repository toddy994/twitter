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

class Searcher
  def initialize(client)
    @client = client
  end

  def search(query)
    @client.search(query, count: 100)
  end
end

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ""
  config.consumer_secret     = ""
  config.access_token        = ""
  config.access_token_secret = ""
end

follower = Follower.new(client)
searcher = Searcher.new(client)

ARGV.each do |hashtag|
  query_string = "##{hastag}"
  searcher.search(query_string).each do |tweet|
    follower.follow(tweet.user)
    sleep 5
  end
end
