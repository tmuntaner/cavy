require_relative 'helpers/view_helpers'
require_relative 'helpers/link_helpers'
require_relative 'templates'

module Cavy
  class Railtie < Rails::Railtie
    initializer 'cavy.view_helpers' do
      ActionView::Base.send :include, ViewHelpers
      ActionView::Base.send :include, LinkHelpers
    end
  end
end
