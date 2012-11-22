module YmCore::Model::CountryAccessor

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    def country_accessor(*attrs)
      attrs << :country if attrs.empty?
      attrs.each do |attr|
        define_method(attr) do
          I18n.translate("countries.#{read_attribute("#{attr}_code")}")
        end
      end
    end

  end

end