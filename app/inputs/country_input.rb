class CountryInput < FormtasticBootstrap::Inputs::SelectInput
  
  def self.countries
    @@countries ||= I18n.backend.send(:translations)[:en][:countries]
  end
  
  def select_html
    countries = self.class.countries.map{|code,name| [I18n.translate("countries.#{code}"), code.to_s]}.sort
    builder.select("#{input_name}_code", countries, input_options, input_html_options)
  end
  
end