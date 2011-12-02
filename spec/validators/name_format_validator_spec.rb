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

  it 'accepts valid name format' do
    user.name = 'Homer Simpson'

    user.should be_valid
  end
end
