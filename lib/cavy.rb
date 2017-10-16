require 'cavy/engine'
require 'cavy/railtie' if defined?(Rails)
require 'cavy/uploaders/file_uploader'
require 'cavy/js_web_token'

module Cavy
  mattr_accessor :root, :title, :locales, :default_locale,
                 :raise_not_found_error, :at_least_one_user, :uploader

  self.root = 'home'
  self.title = 'cavy'

  self.locales = [:en]
  self.default_locale = :en
  self.raise_not_found_error = false
  self.at_least_one_user = false
  self.uploader = nil

  def self.config
    yield(self)
    set_locale
  end

  def self.is_first_time?
    return false if at_least_one_user
    self.at_least_one_user = Cavy::User.count != 0
    !at_least_one_user
  end

  private

  def self.set_locale
    I18n.available_locales = locales unless locales.nil?
    I18n.default_locale = default_locale unless default_locale.nil?
  end
end
