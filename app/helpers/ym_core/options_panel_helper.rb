module YmCore::OptionsPanelHelper

  def options_panel(*args,&block)
    if block_given?
      content_tag(:div, :class => "options_panel mt-2", &block)
    else
      content_tag(:div, args.first, :class => "options_panel mt-2")
    end
  end
  
end