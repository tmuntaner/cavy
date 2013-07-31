require 'cavy/engine'
require 'cavy/railtie' if defined?(Rails)
require 'mongoid'

module Cavy
  
  mattr_accessor :root, :title, :locales, :default_locale, :raise_not_found_error, :google_analytics_username, :google_analytics_password, :google_analytics_property_id

  self.root           = 'home'
  self.title          = 'cavy'
  
  # need to set strings to something
  self.google_analytics_username    = ' '
  self.google_analytics_password    = ' '
  self.google_analytics_property_id = ' '

  self.locales        = :en
  self.default_locale = :en
  self.raise_not_found_error = false

  def self.config(&block)
    yield(self)
    set_locale
    config_mongo
  end

  private

  def self.set_locale
    I18n.available_locales  = self.locales          if self.locales != nil
    I18n.default_locale     = self.default_locale   if self.default_locale != nil
  end

  def self.config_mongo
    Mongoid.raise_not_found_error = self.raise_not_found_error
  end

end