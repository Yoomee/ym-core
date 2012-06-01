module YmCore::TabsHelper
  
  def tabs(*args)
    locals = args.extract_options!
    tabs = args
    tab_links = ''
    tab_panes = ''
    tabs.each_with_index do |tab, idx|
      tab_name, tab_path, tab_title = tab_name_path_title(tab)
      tab_links << content_tag(:li, :class => "#{'active' if idx.zero?}") do
        link_to(tab_title, "##{tab_name}", :'data-toggle' => 'tab')
      end
      tab_panes << content_tag(:div, :class => "tab-pane#{' active' if idx.zero?}", :id => tab_name) do
        render(tab_path, locals)
      end
    end
    content_tag(:div, :class => 'tabbable') do
      "".tap do |out|
        out << content_tag(:ul, tab_links.html_safe, :class => 'nav nav-tabs')
        out << content_tag(:div, tab_panes.html_safe, :class => 'tab-content')
      end.html_safe
    end
  end
      
  private  
  def tab_name_path_title(tab)
    if tab.is_a?(String)
      tab_name_path_title([tab,tab.split(/\//).last.titleize])
    else
      tab_name_path, tab_title = tab
      tab_name = tab_name_path.match(/\//) ? tab_name_path.split(/\//).last : tab_name_path
      tab_path = tab_name_path.match(/\//) ? tab_name_path : "#{controller_name}/tabs/#{tab_name_path}"
      [tab_name, tab_path, tab_title]
    end
  end
  
end
