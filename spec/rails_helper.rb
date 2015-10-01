ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rspec'
require 'devise'

Capybara.default_driver = :selenium
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
  config.use_transactional_fixtures = false

  config.before(:suite) do
   DatabaseCleaner.logger = Rails.logger
   DatabaseCleaner.strategy = :truncation
   DatabaseCleaner.clean_with(:truncation)
 end

 config.around(:each) do |example|
  DatabaseCleaner.cleaning { example.run }
 end
  config.include Rails.application.routes.url_helpers
  config.include FactoryGirl::Syntax::Methods

  config.include Devise::TestHelpers, type: :controller
  config.include ControllerMacros, type: :controller

  config.infer_spec_type_from_file_location!
end
