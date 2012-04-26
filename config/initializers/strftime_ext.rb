module StrftimeExtensions
  
  def self.included(base)
    base.class_eval do
      def strftime_with_ext(fmt='%F')
        format = fmt.dup
        format.gsub!(/%o/, day.ordinalize)
        format.gsub!(/%O/, Date.today.year == year ? '' : " #{year}")
        strftime_without_ext format
      end
      alias_method_chain :strftime, :ext
    end
  end

end

Date.send(:include,StrftimeExtensions)
Time.send(:include,StrftimeExtensions)
