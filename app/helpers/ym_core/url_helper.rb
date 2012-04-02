module YmCore::UrlHelper
  
  def back_link
    link_to('Back',:back)
  end
  
  def externalize_url(url)
    url =~ /^http:\/\// ? url : "http://#{url}"
  end
  
  def link_to_self(*args, &block)
    link_to(*args.insert(0, *args.first), &block)
  end
  
  def link_to_url(url, *args, &block)
    options = args.extract_options!.symbolize_keys.reverse_merge!(:http => true, :target => "_blank")
    link_url = externalize_url(url)
    url = url.sub(/^https?:\/\//, '') if !options[:http]
    link_to(url, link_url, options, &block)
  end
  
end