class DateValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    if options[:after]
      message = options[:message] || "must be after #{options[:after]}"
      record.errors[attribute] << message unless value.blank? || value > options[:after]
    else
      record.errors[attribute] << "is invalid" unless value.blank? || value.to_s =~ UrlValidator::DATE_FORMAT
    end
  end
end

UrlValidator::DATE_FORMAT = /\d\d?\/\d\d?\/\d{4}/