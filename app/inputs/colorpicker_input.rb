class ColorpickerInput < FormtasticBootstrap::Inputs::StringInput
  
  def options
    prepend_html = template.content_tag(:i, '', :style => "background-color: #{@object.send(@method)};")
    super.merge(:prepend => prepend_html)
  end
  
  def wrapper_html_options
    options = super.merge(:class => "#{super[:class]} colorpicker-component colorpicker-control".strip)
    options
  end
  
end