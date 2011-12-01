class EmailFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^(?:[^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
      record.errors[attribute] << (options[:message] || "is not a valid email")
    end
  end
end

module ClientSideValidations::Middleware
  class EmailFormat < Base
    def response
      if request.params[:email] =~ /^(?:[^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
        self.status = 200
      else
        self.status = 404
      end
      super
    end
  end
end
