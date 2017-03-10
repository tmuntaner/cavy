require_dependency 'cavy/application_controller'

module Cavy
  class PagesController < ApplicationController

    def page
      @page = params[:route] ? get_page(params[:route]) : Page.find_by(route: Cavy.root)
      if @page
        render @page.render || 'cavy/pages/page'
      else
        render 'cavy/pages/page'
      end
    end

    private

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end

    def get_page(route)
      Page.find_by(route: route) || not_found
    end

  end
end
