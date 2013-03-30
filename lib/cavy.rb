require "cavy/engine"

module Cavy
  
  mattr_accessor :root, :title, :locales, :default_locale

  def self.config(&block)
    yield(self)
    set_locale
  end

  private

  def self.set_locale
    I18n.available_locales  = self.locales          if self.locales != nil
    I18n.default_locale     = self.default_locale   if self.default_locale != nil
  end

end