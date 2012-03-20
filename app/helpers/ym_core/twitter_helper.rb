require 'open-uri'
module YmCore::TwitterHelper

  # TODO: cache latest_tweets
  def latest_tweets(screen_name, options = {})
    options.reverse_merge!(:count => 1, :include_entities => false, :exclude_replies => true)
    options[:screen_name] = screen_name
    tweets_json = open("http://api.twitter.com/1/statuses/user_timeline.json?#{options.to_param}").read
    tweets_array = ActiveSupport::JSON.decode(tweets_json)
    if tweets_array.is_a?(Array)
      tweets_array.collect {|t| Struct::Tweet.new(t["text"], Time.parse(t["created_at"]), t["user"]["screen_name"], t["id"])}
    else
      Rails.logger.info("FAILED to fetch_latest_tweets_for #{screen_name}: Twitter error: #{tweets_array["error"]}")
      []      
    end
  end

  def latest_tweet(screen_name, options = {})
    latest_tweets(screen_name, options.merge(:count => 1)).first
  end

end

Struct.new("Tweet", :text, :created_at, :screen_name, :id) unless Struct.const_defined?(:Tweet)