require 'open-uri'
module YmCore::TwitterHelper

  def auto_link_twitter(tweet)
    auto_link_twitter_hash_tags(auto_link_twitter_users(auto_link(tweet, :all, :target => "_blank"))).html_safe
  end
  
  def auto_link_twitter_users(tweet)
    tweet.gsub(/@([\w|\d]+)/, '<a target="_blank" href="http://www.twitter.com/\1">@\1</a>')
  end
  
  def auto_link_twitter_hash_tags(tweet)
    tweet.gsub(/#([\w|\d]+)/, '<a target="_blank" href="http://twitter.com/search?q=%23\1">#\1</a>')
  end
  
  def twitter_widget(username,options={})
    options.reverse_merge!(
      :count => 5,
      :width => "'auto'",
      :height => 300,
      :scrollbar => true
    )
    unless @included_twitter_widget_js
      content_for :head do
        javascript_include_tag("http://widgets.twimg.com/j/2/widget.js")
      end
      @included_twitter_widget_js = true
    end
    widget_js = <<-JAVASCRIPT
      new TWTR.Widget({
        version: 2,
        type: 'profile',
        rpp: #{options[:count]},
        interval: 30000,
        width: #{options[:width]},
        height: #{options[:height]},
        theme: {
          shell: {
            background: '#999999',
            color: '#ffffff'
          },
          tweets: {
            background: '#ffffff',
            color: '#333333',
            links: '#3B5998'
          }
        },
        features: {
          scrollbar: #{options[:scrollbar]},
          loop: false,
          live: false,
          behavior: 'all'
        }
      }).render().setUser('#{username}').start();
    JAVASCRIPT
    javascript_tag(widget_js)
  end

  # TODO: cache latest_tweets
  def latest_tweets(screen_name, options = {})
    # NB exclude_replies is applied AFTER count  
    options.reverse_merge!(:count => 1, :include_entities => false, :exclude_replies => true, :trim_user => true)
    Rails.cache.fetch("latest_tweets_#{screen_name}_#{options.to_query}", :expires_in => 1.hour) do
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
  end

  def latest_tweet(screen_name, options = {})
    latest_tweets(screen_name, options.reverse_merge(:count => 10)).first
  end

end

Struct.new("Tweet", :text, :created_at, :screen_name, :id) unless Struct.const_defined?(:Tweet)