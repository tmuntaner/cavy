ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl_rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'simplecov'

SimpleCov.start

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.include AuthMacros
  config.include MailerMacros
  config.include Capybara::DSL, :example_group => { :file_path => /\bspec\/integration\// }
  config.before(:each) do
    reset_email
  end
  config.after(:each) do
  end
end
