require 'spec_helper'

describe NameFormatValidator do
  before(:all) do
    class UserWithName < ActiveRecord::Base
      set_table_name 'mocked_users'

      validates :name, name_format: true
    end
  end

  let(:user) { UserWithName.new }

  it 'does not accept invalid name format' do
    user.name = '#@$%@#%invalid name!!'

    user.should_not be_valid
  end

  it 'accepts names consisting of one word' do
    user.name = 'bill'

    user.should be_valid
  end

  it 'accepts more than one words separated with space' do
    user.name = 'Homer Simpson'

    user.should be_valid
  end

  it 'accepts more than one words separated with dash' do
    user.name = 'Mary-Jane'

    user.should be_valid
  end

  it 'does not accept names not starting with a letter' do
    user.name = '-Bill'

    user.should_not be_valid
  end

  it 'does not validate empty values' do
    user.name = ''

    user.should be_valid
  end

  it 'does not validate nil values' do
    user.name = nil

    user.should be_valid
  end
end
