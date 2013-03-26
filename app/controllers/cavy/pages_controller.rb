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

    private

      def not_found
        raise ActionController::RoutingError.new('Not Found')
      end

      def set_page
        @page = params[:title]? get_page(params[:title]) : Page.find_by(title: Cavy.root)
      end

      def get_page(title)
        Page.find_by(title: title) || not_found
      end

  end
end
