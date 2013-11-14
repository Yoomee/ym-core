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
  
  def latest_tweets(screen_name, options = {})
    # NB exclude_replies is applied AFTER count  
    options.reverse_merge!(:count => 1, :include_entities => false, :exclude_replies => true, :trim_user => true)
    Rails.cache.fetch("latest_tweets_#{screen_name}_#{options.to_query}", :expires_in => 1.hour) do
      options[:screen_name] = screen_name
      tweets_json = open("https://api.twitter.com/1.1/statuses/user_timeline.json?#{options.to_param}", "Authorization" => "Bearer #{Settings.twitter.bearer_token}").read
      tweets_array = ActiveSupport::JSON.decode(tweets_json)
      if tweets_array.is_a?(Array)
        tweets_array.collect {|t| Struct::Tweet.new(t["text"], Time.parse(t["created_at"]), t["user"]["screen_name"], t["id"], t["user"]["profile_image_url"])}
      else
        Rails.logger.info("FAILED to fetch_latest_tweets_for #{screen_name}: Twitter error: #{tweets_array["error"]}")
        []      
      end
    end
  end

  def latest_tweet(screen_name, options = {})
    latest_tweets(screen_name, options.reverse_merge(:count => 10)).first
  end

  def twitter_share_link(*args)
    options = args.extract_options!
    text, resource_or_url = args.size > 1 ? [args[0], args[1]] : ["<i class='icon-twitter'></i> <strong>Tweet</strong>".html_safe, args[0]]
    link_options = {:class => "#{options.delete(:class)} btn twitter share-twitter".strip, :icon => options.delete(:icon), :data => {:ga_event => options.delete(:ga_event)}}
    link_to(text, twitter_share_url(resource_or_url, options), link_options)
  end

  def twitter_share_url(resource_or_url, options = {})
    if resource_or_url.is_a?(String)
      options[:url] = resource_or_url
    else
      options[:url] = Settings.live_site_url + polymorphic_path(resource_or_url)
    end
    options[:url] = Settings.live_site_url + options[:url] unless options[:url] =~ /^http/
    options[:text] = truncate(options[:text], :length => 115) if options[:text]
    "https://twitter.com/share?#{options.to_query}"
  end

  def twitter_widget(username, widget_id, options={})
    options.reverse_merge!(
      :class => 'twitter-timeline',
      :data => {
        # :chrome => 'nofooter', hides reply box
        :tweet_limit => 5
      }
    )
    options[:data][:'widget-id'] = widget_id
    unless @included_twitter_widget_js
      content_for :head do
        javascript_tag("!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document,'script','twitter-wjs');")
      end
      @included_twitter_widget_js = true
    end
    link_to("Tweets by @#{username}", "https://twitter.com/#{username}", options)
  end

end

Struct.new("Tweet", :text, :created_at, :screen_name, :id, :image_url) unless Struct.const_defined?(:Tweet)