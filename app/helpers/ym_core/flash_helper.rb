module YmCore::FlashHelper
  
  def render_flash
    flash.map do |key, val|
      content_tag(:div, alert_dismiss_link + val, :class => alert_class(key))
    end.join.html_safe
  end
  
  private
  def alert_dismiss_link
    content_tag(:a, 'x', :class => 'close', 'data-dismiss' => 'alert')
  end
  
  def alert_class(key)
    "alert " + case key.to_s
    when 'error' then 'alert-error'
    when 'notice' then 'alert-info'
    else ''
    end.strip
  end
  
end
