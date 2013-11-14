module YmCore::FacebookHelper

  def facebook_likebox(url, options={})
    options.reverse_merge!(
      :width => "100%",
      :height => "300px",
      :colorscheme => "light",
      :show_faces => false,
      :stream => true,
      :header => false
    )
    options[:href] = url
    content_tag(:iframe, '', :src => "//www.facebook.com/plugins/likebox.php?#{options.to_query}", :scrolling => "no", :allowTransparency => "true", :style => "border:none; overflow:hidden; width:#{options[:width]}; height:#{options[:height]};")
  end

  def facebook_post_to_feed_link(*args)
    init_facebook_post_to_feed
    options = args.extract_options!
    text, resource = args.size > 1 ? [args[0], args[1]] : ["<i class='icon-facebook'></i> <strong>Facebook</strong>".html_safe, args[0]]
    link_options = {:class => "#{options.delete(:class)} btn facebook share-facebook".strip, :icon => options.delete(:icon)}
    link_to(text, '#', link_options.merge(:data => facebook_post_to_feed_data(resource, options)))
  end

  def facebook_post_to_feed_data(resource, options = {})
    data = resource.is_a?(Hash) ? resource : options.reverse_merge(resource.to_facebook_hash)
    data[:ga_event] = options[:ga_event]
    if data[:url].blank?
      if data[:path].blank? && !resource.is_a?(Hash)
        data[:path] = polymorphic_path(resource)
      end
      data[:url] = "#{Settings.site_url}#{data.delete(:path)}"
    end
    data[:description] = strip_tags(data[:description])
    data[:image_url] = URI.decode(data[:image_url]) if data[:image_url]
    data
  end

  private
  def init_facebook_post_to_feed
    content_for :head do
      js = javascript_tag_once(:init_facebook_post_to_feed, "$(function() { Facebook.init('#{Settings.facebook.app_id}'); Facebook.initPostToFeedLinks(); });")
      javascript_include_tag_once('https://connect.facebook.net/en_GB/all.js') + js
    end
  end
  
end