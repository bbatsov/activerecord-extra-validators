class BooleanValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'is not a valid boolean value') unless BooleanValidator.boolean?(value)
  end

  def self.boolean?(value)
    value == nil || %w(true false 1 0).include?(value.to_s)
  end
end

if defined?(::Rails)
  module ClientSideValidations::Middleware
    class Boolean < Base
      def response
        if BooleanValidator.boolean?(request.params[:boolean])
          self.status = 200
        else
          self.status = 404
        end
        super
      end
    end
  end
end
