module YmCore::UrlHelper
  
  def back_link(text="Back", html_options = {})
    link_to(text, :back, html_options)
  end
  
  def externalize_url(url)
    url =~ /^http:\/\// ? url : "http://#{url}"
  end
  
  def link_to_self(*args, &block)
    link_to(*args.insert(0, *args.first), &block)
  end
  
  def link_to_url(url, *args, &block)
    options = args.extract_options!.symbolize_keys.reverse_merge!(:http => true, :auto_target => true)
    link_url = externalize_url(url)
    if options[:auto_target]
      if link_url =~ %r{^#{Settings.site_url}}
        options.delete(:target)
      else
        options[:target] = "_blank"
      end
    else
      options.reverse_merge!(:target => "_blank")
    end
    url.sub(/^https?:\/\//, '') if !options[:http]
    title = options[:title] || url
    link_to(title, link_url, options, &block)
  end
  
end