class UrlFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^(?:https?:\/\/)?[a-z.0-9]+\.[a-z.]{2,}/i
      record.errors[attribute] << (options[:message] || "is not a valid url")
    end
  end
end
