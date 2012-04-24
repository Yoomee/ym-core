class DateValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    record.errors[attribute] << "is invalid" unless value.blank? || value.to_s =~ UrlValidator::DATE_FORMAT
  end
end

UrlValidator::DATE_FORMAT = /\d\d?\/\d\d?\/\d{4}/