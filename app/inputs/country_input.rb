class CountryInput < FormtasticBootstrap::Inputs::SelectInput
  
  def self.countries
    @@countries ||= I18n.backend.send(:translations)[:en][:countries]
  end
  
  def association_primary_key
    "#{association_primary_key_for_method(method)}_code"
  end
  
  def select_html
    countries_array = []
    country_codes = CountryInput.countries.sort_by(&:last).collect{|c| c.first.to_s}
    if priority_country_codes = options.delete(:priority_country_codes)
      countries_array += priority_country_codes.map{|code| [I18n.translate("countries.#{code}"), code.to_s]}
      countries_array << ["-------------","  "]
    end
    countries_array += country_codes.map{|code| [I18n.translate("countries.#{code}"), code.to_s]}
    builder.select(input_name, countries_array, input_options, input_html_options).sub(/>-------------/,"disabled=\"disabled\">-------------")
  end
  
end