module Cavy
  class Engine < ::Rails::Engine
    isolate_namespace Cavy
    require 'jquery-rails'

    config.assets.paths << File.expand_path('../../assets/nodigest/cavy', __FILE__)

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.template_engine :haml
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.format :mongoid
      g.assets false
      g.helper false
    end
  end
end
