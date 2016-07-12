require_dependency 'cavy/application_controller'

module Cavy
  class AdminPageDataController < ApplicationController

    layout 'cavy/admin_layout'

    def new
      @page = Cavy::Page.find(params[:id])
      render 'cavy/admin_pages/data/new'
    end

    def create
      @page = Cavy::Page.find(params[:id])
      @page.set_key_value(params[:page][:key], params[:page][:value])
      if @page.save
        redirect_to admin_page_path(@page.id), notice: 'Page was successfully created.'
      else
        render action :new
      end
    end

    private

    def page_params
      # TODO Find a way to use hstore with strong parameters
      # params.require(:page).permit(:title, :render, :route, :tag_string, :description, :key, :value, :data)
    end

  end
end
