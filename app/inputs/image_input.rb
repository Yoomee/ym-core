class ImageInput < FormtasticBootstrap::Inputs::FileInput
  
  def to_html
    generic_input_wrapping do
      out = ""
      if object.send(input_name)
        out << template.image_for(object, '60x60#', :method => input_name)
      end
      out << "<div class='image-inputs'>"
      out << builder.file_field(method, input_html_options)
      out << builder.hidden_field("retained_#{input_name}")
      if object.send("#{input_name}_uid").present?
        out << template.content_tag(:label, :class => 'checkbox remove-image') do
          builder.check_box("remove_#{input_name}") + " Remove #{label_text.downcase.gsub('<abbr title="required">*</abbr>', '')}"
        end
      end
      out << "</div>"
    end
  end    
  
  def wrapper_html_options
    super.merge(:class => super[:class].sub('file', 'image'))
  end
  
end