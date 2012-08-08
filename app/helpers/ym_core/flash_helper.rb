module YmCore::FlashHelper
  
  def render_flash
    flash.map do |key, val|
      if key == :modal
        render_modal(val)
      else
        content_tag(:div, dismiss_link('x','alert') + val.html_safe, :class => alert_class(key))
      end
    end.join.html_safe
  end
  
  private
  def dismiss_link(title, dismiss)
    content_tag(:a, title, :class => dismiss == 'modal' ? 'btn btn-primary' : 'close', 'data-dismiss' => dismiss)
  end
  
  def alert_class(key)
    "alert " + case key.to_s
    when 'error' then 'alert-error'
    when 'notice' then 'alert-info'
    else ''
    end.strip
  end
  
  def render_modal(modal)
    return "" if modal.blank?
    if modal.is_a?(Hash)
      modal_title = modal[:title]
      modal_text = modal[:text]
    else
      modal_title = ''
      modal_text = modal
    end
    head = modal_title.present? ? content_tag(:div, content_tag(:h3,modal_title), :class => 'modal-header') : ''
    body = content_tag(:div, modal_text, :class => 'modal-body')
    foot = content_tag(:div, dismiss_link('OK','modal'), :class => 'modal-footer')
    content_tag(:div, (head + body + foot).html_safe, :id => 'flash-modal', :class => 'modal hide fade')
  end
  
end
