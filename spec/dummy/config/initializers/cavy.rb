Cavy.config do |config|
  config.root = 'home'
  config.title = 'Cavy Test'
  config.locales = [:en, :de, :wk]
  config.default_locale = :en
  config.uploader = Cavy::FogUploader.new
end
