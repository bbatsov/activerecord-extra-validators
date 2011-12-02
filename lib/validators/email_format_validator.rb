class EmailFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'is not a valid email') unless EmailFormatValidator.valid_email?(value)
  end

  def self.valid_email?(value)
    value =~ /^(?:[^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  end
end

if defined?(::Rails)
  module ClientSideValidations::Middleware
    class EmailFormat < Base
      def response
        if EmailFormatValidator.valid_email?(request.params[:email])
          self.status = 200
        else
          self.status = 404
        end
        super
      end
    end
  end
end
