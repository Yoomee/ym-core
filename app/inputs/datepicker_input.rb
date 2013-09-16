class DatepickerInput < FormtasticBootstrap::Inputs::StringInput
  
  def input_html_options
    set_method
    options = super.merge(:class => "#{super[:class]} datepicker".strip)
    options[:placeholder] = 'dd/mm/yyyy' if options[:placeholder].nil?
    options
  end
  
  private
  def set_method
    return true if 
    if !@method.to_s.ends_with?('_s') && @object.respond_to?("#{@method}_s")
      @method = "#{@method}_s".to_sym
    end
  end
  
end