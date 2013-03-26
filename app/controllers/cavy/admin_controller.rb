require_dependency "cavy/application_controller"

module Cavy
  class AdminController < ApplicationController

    layout 'layouts/cavy/admin_layout'

    def overview
    end

    def users
    end

    def pages
    end

    def new_page
      @page = Cavy::Page.new
    end

    def page
      @page = Cavy::Page.find(params[:id])
    end

    def update_page

    end

    def create_page
      @page = Page.new(page_params)

      if @page.save
        redirect_to admin_page_path(@page), notice: 'Page was successfully created.'
      else
        render action: 'new_page'
      end
    end

    def update_page
      @page = Page.find(params[:id])
      if @page.update(page_params)
        redirect_to admin_page_path(@page), notice: 'Page was successfully created.'
      else
        render action: 'edit_page'
      end
    end

    def edit_page
      @page = Cavy::Page.find(params[:id])
    end

    def new_user

    end

    private

      def page_params
        params.require(:page).permit(:title, :render)
      end

  end
end
