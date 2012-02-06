class DateFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'is not a valid date format') unless value.blank? || DateFormatValidator.valid_date_format?(value)
  end

  def self.valid_date_format?(value)
    valid_parsed_date_format?(value) || valid_localized_date_format?(value)
  end

  private
  # Check whether given string can be parsed to a valid date using Date.parse
  def self.valid_parsed_date_format?(value)
    begin
      parsed_date = Date.parse(value)
    rescue
      # do nothing
    end

    parsed_date.present?
  end

  # Check whether given string can be parsed with some of the date.format options given in the localization settings
  def self.valid_localized_date_format?(value)
    parsed_date = nil

    I18n.t('date.formats').each_value do |format|
      begin
        parsed_date = Date.strptime(value, format)
      rescue
        #do nothing
      end
    end

    parsed_date.present?
  end
end

if defined?(::Rails)
  module ClientSideValidations::Middleware
    class DateFormat < Base
      def response
        if DateFormatValidator.valid_date_format?(request.params[:date])
          self.status = 200
        else
          self.status = 404
        end
        super
      end
    end
  end
end
