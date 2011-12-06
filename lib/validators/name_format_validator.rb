class NameFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'is not a valid name') unless value.blank? || NameFormatValidator.valid_name?(value)
  end

  def self.valid_name?(value)
    value =~ /^[\p{Alpha}][\p{Alpha}\s-]*$/i
  end
end

if defined?(::Rails)
  module ClientSideValidations::Middleware
    class NameFormat < Base
      def response
        if NameFormatValidator.valid_name?(request.params[:name])
          self.status = 200
        else
          self.status = 404
        end
        super
      end
    end
  end
end
