Cavy.config do |config|
  config.root = 'home'
  config.title = 'Cavy Test'
  config.locales = [:en,:de]
  config.default_locale = :en
  config.google_analytics_username    = ENV['GOOGLE_ANALYTICS_USERNAME']
  config.google_analytics_password    = ENV['GOOGLE_ANALYTICS_PASSWORD']
  config.google_analytics_property_id = ENV['GOOGLE_ANALYTICS_PROPERTY_ID']
end