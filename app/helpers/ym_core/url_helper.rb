module YmCore::UrlHelper
  
  def link_to_self(*args, &block)
    link_to(*args.insert(0, *args.first), &block)
  end
  
end