require 'spec_helper'

describe BooleanValidator do
  before(:all) do
    class UserWithBoolean < ActiveRecord::Base
      self.table_name = 'mocked_users'

      validates :active, boolean: true
    end
  end

  let(:user) { UserWithBoolean.new }

  it 'does no accept invalid boolean values' do
    user.active = 'invalid'

    user.should_not be_valid
  end

  it 'accepts "true" as a valid value' do
    user.active = 'true'

    user.should be_valid
  end

  it 'accepts "false" as a valid value' do
    user.active = 'false'

    user.should be_valid
  end

  it 'accepts "0" as a valid value' do
    user.active = '0'

    user.should be_valid
  end

  it 'accepts "1" as a valid value' do
    user.active = 'true'

    user.should be_valid
  end

  it 'accepts true as a valid value' do
    user.active = true

    user.should be_valid
  end

  it 'accepts false as a valid value' do
    user.active = false

    user.should be_valid
  end

  it 'accepts nil as a valid value' do
    user.active = nil

    user.should be_valid
  end
end
