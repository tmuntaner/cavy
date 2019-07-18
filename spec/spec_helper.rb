ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../dummy/config/environment.rb', __FILE__)

require 'rspec/rails'
require 'factory_girl_rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'factory_girl_rails'
require 'database_cleaner'
require 'pry'
require 'simplecov'

SimpleCov.start

Capybara.default_max_wait_time = 10
Capybara.javascript_driver = :webkit
Capybara.ignore_hidden_elements = false

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.infer_spec_type_from_file_location!
  config.order = 'random'
  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL
  config.include AuthMacros
  config.include MailerMacros
  config.include Cavy::Engine.routes.url_helpers
  config.before(:each, type: :controller) { @routes = Cavy::Engine.routes }
  config.before(:each, type: :routing) { @routes = Cavy::Engine.routes }
  config.include Requests::JsonHelpers, type: :request

  config.before(:each) do
    reset_email
    DatabaseCleaner.clean_with :truncation, except: [
      ActiveRecord::InternalMetadata.table_name
    ]
    DatabaseCleaner.start
    Cavy.at_least_one_user = false
    I18n.default_locale = :en
    I18n.locale = :en
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
    Capybara.reset_sessions!
  end
end
