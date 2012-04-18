module YmCore::TextHelper
  
  def summarize(resource, options = {})
    if resource.respond_to?(:summary) && resource.summary.present?
      summary = options[:length] ? truncate(resource.summary, :length => options[:length]) : resource.summary
      simple_format(summary)
    elsif resource.respond_to?(:text) && resource.text.present?
      summary = sanitize(resource.text, :tags => %w{p br})
      summary = truncate_html(summary, :length => options[:length]) if options[:length]
      summary
    else
      resource.to_s
    end
  end
  
end