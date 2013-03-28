$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cavy/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cavy"
  s.version     = Cavy::VERSION
  s.authors     = ["Thomas Muntaner", "Susanne Schmidt"]
  s.email       = ["thomas.muntaner@rubyrainbows.com", "susanne.schmidt@rubyrainbows.com"]
  s.homepage    = "http://www.rubyrainbows.com"
  s.summary     = "A simple CMS for rails"
  s.description = "A cms bootstrap for localized client websites."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'rails',       '~> 4.0.0.beta1'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'coffee-script'
  s.add_dependency 'haml'
  s.add_dependency 'carrierwave'
  s.add_dependency 'mini_magick'
  s.add_dependency 'pg'
  s.add_dependency 'bcrypt-ruby'
  s.add_dependency 'globalize3'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'meta_request'
  s.add_development_dependency 'unicorn'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'better_errors'
  s.add_development_dependency 'binding_of_caller'
end
