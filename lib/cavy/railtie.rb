require_relative 'helpers/view_helpers'

module Cavy
  class Railtie < Rails::Railtie
    initializer 'cavy.view_helpers' do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end