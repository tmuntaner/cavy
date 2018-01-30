$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'cavy/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = 'cavy'
  s.version = Cavy::VERSION
  s.authors = ['Thomas Muntaner', 'Susanne Schmidt']
  s.email = ['thomas.muntaner@rubyrainbows.com', 'susanne.schmidt@rubyrainbows.com']
  s.homepage = 'http://www.rubyrainbows.com'
  s.summary = 'A simple CMS for rails'
  s.description = 'A cms bootstrap for localized client websites.'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 5.0.0'
  s.add_dependency 'pg', '~> 0.18.0'
  s.add_dependency 'jquery-rails', '~> 4.3.0'
  s.add_dependency 'coffee-script'
  s.add_dependency 'haml'
  s.add_dependency 'haml-rails', '~> 1.0.0'
  s.add_dependency 'carrierwave'
  s.add_dependency 'mini_magick'
  s.add_dependency 'bcrypt-ruby'
  s.add_dependency 'garb'
  s.add_dependency 'jquery-ui-rails', '~> 6.0.1'
  s.add_dependency 'globalize', '~> 5.1.0'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'meta_request'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'awesome_print'
end
