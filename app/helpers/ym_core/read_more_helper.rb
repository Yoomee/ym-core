module YmCore::ReadMoreHelper

  def read_more_truncate(text, options = {})
    options.reverse_merge!(:length => 400, :more_link => "Read more", :omission => "...")
    read_more_link = "#{options[:omission]} #{link_to(options[:more_link], '#', :class => 'read-more-link')}"
    full_text = content_tag(:span, text, :class => 'read-more-full').html_safe
    trunc_text = content_tag(:span, HTML_Truncator.truncate(text, options[:length], :length_in_chars => true, :ellipsis => read_more_link).html_safe, :class => 'read-more-trunc').html_safe
    content_tag(:span, trunc_text + full_text, :class => 'read-more-wrapper').html_safe
  end
  
end