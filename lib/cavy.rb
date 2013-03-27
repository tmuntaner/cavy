require "cavy/engine"

module Cavy
  
  mattr_accessor :root, :title, :locales

  def self.config(&block)
    yield(self)
    set_locale
  end

  def self.set_locale
    if self.locales != nil
      I18n.available_locales = self.locales
    end
  end

end