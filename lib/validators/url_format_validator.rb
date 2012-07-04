class UrlFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'is not a valid url') unless value.blank? || UrlFormatValidator.valid_url?(value)
  end

  def self.valid_url?(value)
    value =~ /^((?:https?|ftp):\/\/)?(?:[^:]*:[^@]*@)?(?:(?:[^\s\.:@%#\?]+\.)+[a-z]{2,}|(?:(?:25[0-5]|2[0-4]\d|[01]?\d{1,2})\.){3}(?:25[0-5]|2[0-4]\d|[01]?\d{1,2}))(?:\/|$)/i
  end
end

if defined?(::Rails)
  module ClientSideValidations::Middleware
    class UrlFormat < Base
      def response
        if UrlFormatValidator.valid_url?(request.params[:url])
          self.status = 200
        else
          self.status = 404
        end
        super
      end
    end
  end
end
