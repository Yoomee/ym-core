module YmCore::LayoutHelper

  def yield_with_bootstrap(yield_content, options = {})
    options.reverse_merge!(:container_class => "container", :row_class => "row", :span_class => "span12")
    first_div_class = yield_content.match(/^<div\s+[^>]*class=[\"\']([^\"\']+)[\"\']/i).try(:[], 1).to_s
    if !first_div_class.match(/container/)
      if !first_div_class.match(/row/)
        if !first_div_class.match(/span/)
          yield_content = content_tag(:div, yield_content, :class => options[:span_class])
        end
        yield_content = content_tag(:div, yield_content, :class => options[:row_class])
      end
      yield_content = content_tag(:div, yield_content, :class => options[:container_class])
    end
    yield_content
  end
  
  def yield_with_span(yield_content, options = {})
    options.reverse_merge!(:span_class => "span10")
    first_div_class = yield_content.match(/^<div\s+[^>]*class=[\"\']([^\"\']+)[\"\']/i).try(:[], 1).to_s
    if !first_div_class.match(/span/)
      yield_content = content_tag(:div, yield_content, :class => options[:span_class])
    end
    yield_content
  end

  def body_tag(options = {}, &block)
    options[:id] ||= id_for_body_tag
    body_class = "#{classes_for_body_tag} #{options[:class]}".strip
    options[:class] = body_class unless body_class.blank?
    concat content_tag(:body, capture(&block), options)
  end

  def content_tag_with_active(*args, &block)
    options = args.extract_options!.symbolize_keys
    options ||= {}
    options[:class] = (options[:class].blank? ? "active" : options[:class] + " active") if args.second
    if block_given?
      content_tag(args.first, options, &block)
    else
      content_tag(args.first, args.third, options)
    end
  end

  def li_with_active(*args, &block)
    content_tag_with_active(:li, *args, &block)
  end

  private
  def id_for_body_tag
    is_home? ? 'home' : 'inside'
  end
  
  def is_home?
    @is_home || controller_name == "home"
  end

  def classes_for_body_tag
    [].tap do |classes|      
      classes << "controller_#{controller_name}"
      classes << "action_#{action_name}"
      classes << (user_signed_in? ? 'logged_in' : 'logged_out')
      classes << "root_slug_#{@page.root_slug}" if defined?(@page) && @page && @page.root && @page.root_slug.present?
      classes << "slug_#{@page.slug}" if defined?(@page) && @page && @page.slug.present?
    end.join(' ')
  end

end
