module YmCore::JavascriptHelper

  def javascript_tag_once(*args, &block)
    key = args.shift
    unless included_javascript?(key)
      include_javascript!(key)
      javascript_tag(*args, &block)
    end
  end

  def javascript_include_tag_once(*sources)
    unincluded_sources = sources.reject{|source| included_javascript?(source)}
    include_javascript!(unincluded_sources)
    javascript_include_tag(*unincluded_sources)
  end

  private
  def included_javascript?(key)
    @included_javascript ||= []
    @included_javascript.include?(key.to_s)
  end

  def include_javascript!(keys)
    @included_javascript ||= []
    @included_javascript += [*keys].collect(&:to_s)
  end

end