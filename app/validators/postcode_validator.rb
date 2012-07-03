class PostcodeValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    record.errors[attribute] << "is not a valid postcode" unless value.upcase!.to_s =~ PostcodeValidator::POSTCODE_FORMAT
  end
end

PostcodeValidator::POSTCODE_FORMAT = /\A[A-Z]{1,2}[0-9R][0-9A-Z]? [0-9][A-Z-[CIKMOV]]{2}\z/