module YmCore::TabsHelper
  
  def tabs(*args)
    locals = args.extract_options!
    tabs = args
    tab_links = ''
    tab_panes = ''
    tabs.each_with_index do |tab, idx|
      tab_title, tab_name = tab_title_and_name(tab)
      tab_links << content_tag(:li, :class => "#{'active' if idx.zero?}") do
        link_to(tab_title, "##{tab_name}", :'data-toggle' => 'tab')
      end
      tab_panes << content_tag(:div, :class => "tab-pane#{' active' if idx.zero?}", :id => tab_name) do
        render("#{controller_name}/tabs/#{tab_name}", locals)
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
  def tab_title_and_name(tab)
    tab_name = tab.is_a?(Array) ? tab[0] : tab
    tab_title = tab.is_a?(Array) ? tab[1] : tab_name.titleize
    [tab_title, tab_name]
  end
  
end
