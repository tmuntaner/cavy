require_relative 'boot'

require 'rails/all'
require 'jquery-rails'
require 'carrierwave'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dummy
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.assets.precompile += %w(cavy/mercury.css cavy/mercury_loader.js cavy/mercury_save.js cavy/mercury.js)
    I18n.enforce_available_locales = false

  end
end
