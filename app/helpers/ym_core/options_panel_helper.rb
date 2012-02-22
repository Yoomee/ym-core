module YmCore::OptionsPanelHelper

  def options_panel(*args,&block)
    if block_given?
      content_tag(:div, :class => "options_panel", &block)
    else
      content_tag(:div, args.first, :class => "options_panel")
    end
  end
  
end