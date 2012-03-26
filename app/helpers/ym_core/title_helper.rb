module YmCore::TitleHelper
  
  def title(text)
    @page_title ||= text
  end
  
end