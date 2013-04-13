require_dependency "cavy/application_controller"

module Cavy
  class PagesController < ApplicationController

    before_action :set_page, only: [:page, :edit]

    def page
      if @page
        render @page.render || 'cavy/pages/page'
      else
        render 'cavy/pages/page'
      end
    end

    def edit
      @edit = true
      render @page.render || 'cavy/pages/page'
    end

    def update
      @page = Page.find(params[:id])
      @page.update_elements(params[:content])
      render text: ''
    end

    private

      def not_found
        raise ActionController::RoutingError.new('Not Found')
      end

      def set_page
        @page = params[:route]? get_page(params[:route]) : Page.find_by(route: Cavy.root)
      end

      def get_page(route)
        Page.find_by(route: route) || not_found
      end

  end
end
