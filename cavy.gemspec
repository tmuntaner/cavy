$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'cavy/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = 'cavy'
  s.version = Cavy::VERSION
  s.authors = ['Thomas Muntaner', 'Susanne Schmidt']
  s.email = %w(thomas.muntaner@rubyrainbows.com susanne.schmidt@rubyrainbows.com)
  s.homepage = 'http://www.rubyrainbows.com'
  s.summary = 'A simple CMS for rails'
  s.description = 'A cms bootstrap for localized client websites.'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 5.1'
  s.add_dependency 'pg', '~> 0.20'
  s.add_dependency 'coffee-script', '~> 2.4'
  s.add_dependency 'haml', '~> 4.0'
  s.add_dependency 'mini_magick', '~> 4.6'
  s.add_dependency 'bcrypt-ruby', '~> 3.1'
  s.add_dependency 'sass-rails', '~> 5.0'
  s.add_dependency 'jquery-rails', '~> 4.2'
  s.add_dependency 'carrierwave', '~> 1.0'

  s.add_development_dependency 'capybara', '~> 2.12'
  s.add_development_dependency 'meta_request', '~> 0.4'
  s.add_development_dependency 'factory_girl_rails', '~> 4.8'
  s.add_development_dependency 'launchy', '~> 2.4'
  s.add_development_dependency 'database_cleaner', '~> 1.5'
  s.add_development_dependency 'pry', '~> 0.10'
  s.add_development_dependency 'awesome_print', '~> 1.7'
end
