module I18n

  def self.use_english_if_translation_missing(exception, locale, key, options)
    if exception.is_a?(MissingTranslation) && locale == :en
      ExceptionNotifier::Notifier.exception_notification("production", StandardError.new, :data => {:message => "Missing key in config/locales/en.yml #{exception} #{key}"}).deliver
      "English missing"
    elsif exception.is_a?(MissingTranslation) && locale != :en
      I18n.translate(key, (options || {}).merge(:locale => :en))
    elsif exception.is_a?(Exception)
      raise exception
    else
      throw :exception, exception
    end
  end
  
end
 
I18n.exception_handler = :use_english_if_translation_missing if Rails.env.production?
