class UrlValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    record.errors[attribute] << "is invalid" unless value.to_s =~ UrlValidator::URL_FORMAT
  end
end

UrlValidator::URL_FORMAT = /((((file|gopher|news|nntp|telnet|http|ftp|https|ftps|sftp):\/\/)|(www\.)?)+(([a-zA-Z0-9\._-]+\.[a-zA-Z]{2,6})|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(\/[a-zA-Z0-9\&amp;%_\.\/-~-]*)?(?!['"]))|^\s*$/