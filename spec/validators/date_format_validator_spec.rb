require 'spec_helper'

describe DateFormatValidator do
  before(:all) do
    class UserWithDate < ActiveRecord::Base
      self.table_name = 'mocked_users'

      validates :birth_date, date_format: true
    end
  end

  let(:user) { UserWithDate.new }

  it 'does not accept invalid date format' do
    user.birth_date = 'invalid'

    user.should_not be_valid
  end

  it 'accepts valid date format accepted by Date.parse' do
    user.birth_date = '2010-03-21'

    user.should be_valid
  end

  it 'accepts date format specified in localization date.formats options' do
    I18n.stub(:t).with('date.formats').and_return(custom_format: '%Y-%d-%m')

    user.birth_date = '2010-21-03'

    user.should be_valid
  end

  it 'does not accept date formats not accepted by Date.parse and not found in localization options' do
    user.birth_date = '2010-21-03'

    user.should_not be_valid
  end

  it 'does not validate empty values' do
    user.birth_date = ''

    user.should be_valid
  end

  it 'does not validate nil values' do
    user.birth_date = nil

    user.should be_valid
  end
end
