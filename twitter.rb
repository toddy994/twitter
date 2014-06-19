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
  def initialize(client, n = 10)
    @client      = client
    @max_results = n
  end

  def search(query)
    @client.search(query, count: @max_results).take(@max_results)
  end
end

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["consumer_key"]
  config.consumer_secret     = ENV["consumer_secret"]
  config.access_token        = ENV["access_token"]
  config.access_token_secret = ENV["access_token_secret"]
end

follower = Follower.new(client)
searcher = Searcher.new(client, 25)

ARGV.each do |hashtag|
  puts "searching for: #{hashtag}"
  query_string = "##{hashtag}"
  searcher.search(query_string).each do |tweet|
    puts "following #{tweet.user.name}"
    follower.follow(tweet.user)
  end
end
