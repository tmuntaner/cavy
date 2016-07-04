require 'cavy/engine'
require 'cavy/railtie' if defined?(Rails)

module Cavy

  mattr_accessor :root, :title, :locales, :default_locale, :raise_not_found_error

  self.root = 'home'
  self.title = 'cavy'

  self.locales = :en
  self.default_locale = :en
  self.raise_not_found_error = false

  def self.config(&block)
    yield(self)
    set_locale
  end

  private

  def self.set_locale
    I18n.available_locales = self.locales if self.locales != nil
    I18n.default_locale = self.default_locale if self.default_locale != nil
  end

end
