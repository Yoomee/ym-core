module YmCore::TextHelper
  
  def summarize(resource, options = {})
    if resource.respond_to?(:summary) && resource.summary.present?
      summary = options[:length] ? truncate(resource.summary, :length => options[:length]) : resource.summary
      simple_format(summary)
    elsif resource.respond_to?(:text) && resource.text.present?
      summary = sanitize(resource.text, :tags => %w{p br})
      summary = HTML_Truncator.truncate(summary, options[:length], :length_in_chars => true) if options[:length]
      summary
    else
      simple_format(resource.to_s)
    end
  end
  
end