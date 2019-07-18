require_dependency 'cavy/application_controller'

module Cavy
  class PagesController < ApplicationController
    def page
      @page = get_page(params[:route])
      if @page
        render @page.render || 'cavy/pages/page'
      else
        render 'cavy/pages/page'
      end
    end

    private

    def not_found
      raise ActionController::RoutingError, 'Not Found'
    end

    def get_page(route)
      route = '/' + route.to_s unless route.to_s.start_with?('/')
      Page.find_by(route: route) || not_found
    end
  end
end
