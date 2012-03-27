module YmCore::UrlHelper
  
  def externalize_url(url)
    url =~ /^http:\/\// ? url : "http://#{url}"
  end
   
  def link_if_can(*args, &block)
    options = args.extract_options!
    ability_or_resource = args[block_given? ? 0 : 1]
    if ability_or_resource.is_a?(Array)
      return "" unless can?(*ability_or_resource)
      if ability_or_resource[0].to_s == "destroy"
        args[block_given? ? 0 : 1] = ability_or_resource[1]
        options[:method] ||= :delete
      elsif !ability_or_resource[1].is_a?(ActiveRecord::Base)
        ability_or_resource[1] = ability_or_resource[1].to_s.underscore
      end
    else
      return "" unless can?(:read, ability_or_resource)
    end
    args << options
    link_to(*args, &block)
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