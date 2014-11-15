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

gem 'simplecov',        require: false, :group => :test
gem 'coveralls',        require: false
gem 'mongoid',          '>= 4.0.0'
gem 'jquery-ui-rails'
gem 'rails',            '>= 4.1.7'
gem "rspec-rails",      "2.13.2", :group => [:test, :development]
gem "moped", github: "mongoid/moped"

platform :jruby do
  gem 'therubyrhino', group: :asssets
  gem 'puma'
end

platform :ruby do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'unicorn'
end
