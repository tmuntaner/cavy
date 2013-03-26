require_dependency "cavy/application_controller"

module Cavy
  class PagesController < ApplicationController

    before_action :set_page, only: [:page, :edit]

    def page
      render @page.render || 'cavy/pages/page'
    end

    def edit
      @edit = true
      render @page.render || 'cavy/pages/page'
    end

    def update
      @page = Page.find(params[:id])
      @page.update(title: params[:content][:title][:value], content: params[:content][:content][:value])
      render text: ''
    end

    private

      def not_found
        raise ActionController::RoutingError.new('Not Found')
      end

      def set_page
        @page = params[:route]? get_page(params[:route]) : Page.find_by(title: Cavy.root)
      end

      def get_page(route)
        Page.find_by(route: route) || not_found
      end

  end
end
