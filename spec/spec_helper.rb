ENV["RAILS_ENV"] ||= 'test'

require 'rspec'
require 'active_model'
require 'active_model/validations'
require 'active_record'
require 'activerecord-extra-validators'

ActiveRecord::Base.time_zone_aware_attributes = true
ActiveRecord::Base.establish_connection({:adapter => 'sqlite3', :database => ':memory:'})
ActiveRecord::Migration.verbose = false
ActiveRecord::Schema.define(:version => 1) do
  create_table :mocked_users, :force => true do |t|
    t.string :name
    t.string :email
    t.string :url
    t.string :active
  end
end

class MockedUser < ActiveRecord::Base

end

RSpec.configure do |config|
  config.mock_with :rspec
end
