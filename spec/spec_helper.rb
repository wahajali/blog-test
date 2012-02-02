ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/rails'

Capybara.default_driver = :selenium
Capybara.run_server = true
Capybara.default_selector = :xpath
Capybara.default_wait_time = 5 


require 'factory_girl'
require Rails.root.join('db','seeds')

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.include Devise::TestHelpers, :type => :controller
  config.include Capybara::DSL, :type => :request
end
