require "pry"
require "twitter"

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ""
  config.consumer_secret     = ""
  config.access_token        = ""
  config.access_token_secret = ""
end

def search_for_tweets_to(hashtag, client)
  client.search("##{hashtag}", count: 100)
end

def follow_user(user, client)
  client.follow(user)
end

def unfollow_user(user, client)
  client.unfollow(user)
end

number_to_follow = ARGV.shift.to_i

ARGV.each do |hashtag|
  search_for_tweets_to(hashtag, client).each do |tweet|
    follow_user(tweet.user, client)
    sleep 5
  end
end
