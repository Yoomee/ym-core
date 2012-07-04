class PostcodeValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    record.errors[attribute] << "is not a valid postcode" unless (value.to_s.upcase! || value.to_s) =~ PostcodeValidator::POSTCODE_FORMAT
  end
end

PostcodeValidator::POSTCODE_FORMAT = /^([A-PR-UWYZ0-9][A-HK-Y0-9][AEHMNPRTVXY0-9]?[ABEHMNPRVWXY0-9]? {1,2}[0-9][ABD-HJLN-UW-Z]{2}|GIR 0AA)$/i