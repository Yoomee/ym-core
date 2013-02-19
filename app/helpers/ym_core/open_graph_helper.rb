module YmCore::OpenGraphHelper
  
  def open_graph_tag(property, content)
    content_tag(:meta, '', :property => "og:#{property}", :content => content)
  end
  
  def open_graph_tags(hash = {})
    hash.reverse_merge!({
      :title => page_title,
      :url => request.url,
      :type => "website",
      :image => request.protocol + request.host_with_port + image_path("og-image.jpg")
    })
    "".tap do |out|
      hash.each do |property,content|
        out << open_graph_tag(property,content)
      end
    end.html_safe
  end
  
end