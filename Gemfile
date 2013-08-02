source "https://rubygems.org"

# Declare your gem's dependencies in cavy.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'

gem 'simplecov',  require: false, :group => :test
gem 'coveralls',  require: false
gem 'mongoid',    github: 'mongoid/mongoid'
gem 'jquery-ui-rails', github: 'joliss/jquery-ui-rails'
# because of https://github.com/rails/rails/issues/9582
# will remove in next release of rails 4
gem 'rails',      '4.0.0'
gem "rspec-rails", "2.13.2", :group => [:test, :development]


platform :jruby do
  gem 'therubyrhino', group: :asssets
  gem 'puma'
end

platform :ruby do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'unicorn'
end