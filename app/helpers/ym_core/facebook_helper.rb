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
  
end