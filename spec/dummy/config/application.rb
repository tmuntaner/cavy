require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
# require 'krypt/ossl'
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "jquery-rails"
require "carrierwave"
# require "turbolinks"
require "bson"
require "moped"

Moped::BSON = BSON

Bundler.require(*Rails.groups)
require "cavy"

module Dummy
  class Application < Rails::Application
    config.assets.precompile += ["cavy/mercury.css", "cavy/mercury_loader.js", "cavy/mercury_save.js", "cavy/mercury.js"]
    I18n.enforce_available_locales = false
  end
end
