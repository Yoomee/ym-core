class CountryInput < FormtasticBootstrap::Inputs::SelectInput
  
  def self.countries
    @@countries ||= I18n.backend.send(:translations)[:en][:countries]
  end
  
  def association_primary_key
    "#{association_primary_key_for_method(method)}_code"
  end
  
  def select_html
    countries = CountryInput.countries.map{|code,name| [I18n.translate("countries.#{code}"), code.to_s]}.sort
    builder.select(input_name, countries, input_options, input_html_options)
  end
  
end