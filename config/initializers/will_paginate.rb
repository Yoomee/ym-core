WillPaginate::ViewHelpers::LinkRenderer.class_eval do
  
  def link_with_remote(text, target, attributes = {})
    if @options[:remote]
      attributes[:"data-remote"] = true
    end
    link_without_remote(text, target, attributes)
  end
  alias_method_chain :link, :remote  
  
end