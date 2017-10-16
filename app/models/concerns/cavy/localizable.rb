module Cavy::Localizable
  extend ActiveSupport::Concern

  included do
    def localized_hash_value(hash, locale)
      locales = [locale] + [I18n.locale] + [Cavy.default_locale] + Cavy.locales
      locales.inject('') do |working_title, test_locale|
        if working_title == '' && test_locale.to_s != ''
          working_title = hash[test_locale.to_s]
        end
        working_title
      end
    end
  end
end
