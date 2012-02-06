require 'spec_helper'

describe UrlFormatValidator do
  before(:all) do
    class UserWithUrl < ActiveRecord::Base
      set_table_name 'mocked_users'

      validates :url, url_format: true
    end
  end

  let(:user) { UserWithUrl.new }

  it 'does not accept invalid url format' do
    user.url = 'invalid'

    user.should_not be_valid
  end

  it 'accepts valid url format' do
    user.url = 'test.com'

    user.should be_valid
  end

  it 'does not validate empty values' do
    user.url = ''

    user.should be_valid
  end

  it 'does not validate nil values' do
    user.url = nil

    user.should be_valid
  end
end
