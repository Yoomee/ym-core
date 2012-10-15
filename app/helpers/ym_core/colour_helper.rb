module YmCore::ColourHelper
  
  def complementary_color(color, options = {})
    return nil if color.blank?
    options.reverse_merge!(:threshold => 510, :dark_color => '#000000', :light_color => '#FFFFFF')
    case color.sub(/^#/,'').strip.scan(/../).collect(&:hex).inject(0,:+)
    when options[:threshold]..765
      options[:dark_color]
    else
      options[:light_color]
    end
  end
  
end