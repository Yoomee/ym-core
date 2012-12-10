module YmCore::Model::CountryAccessor

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    def country_accessor(*attrs)
      attrs << :country if attrs.empty?
      attrs.each do |attr|
        define_method(attr) do
          if (attr_code = read_attribute("#{attr}_code")).present?
            I18n.translate("countries.#{attr_code}")
          else
            nil
          end
        end
        define_method("#{attr}_changed?") do
          send("#{attr}_code_changed?")
        end
      end
    end

  end

end