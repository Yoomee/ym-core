module YmCore::Model::DateAccessor
  
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
  
    def date_accessors(*args)
      options = args.extract_options!
      format = options[:format] || "%d/%m/%Y"
      args.each do |date_attr|
        self.validates("#{date_attr}_s", :date => true)
        define_method "#{date_attr}_s" do
          instance_variable_get("@#{date_attr}_s") || send(date_attr).try(:strftime, format) || ''
        end
        define_method "#{date_attr}_s=" do |value|
          if value.blank?
            write_attribute(date_attr, nil)
          else
            begin
              write_attribute(date_attr,Date.strptime(value, format))
            rescue ArgumentError
            end
            instance_variable_set("@#{date_attr}_s",value)
          end          
        end
      end
    end
    alias_method :date_accessor, :date_accessors

  end
  
end