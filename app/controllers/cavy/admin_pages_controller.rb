require_dependency 'cavy/application_controller'

module Cavy
  class AdminPagesController < ApplicationController

    layout 'cavy/admin_layout'

    def index
      @pages = Cavy::Page.all
    end

    def add_data
      @page = Cavy::Page.find(params[:id])
    end

    def create_data
      @page = Cavy::Page.find(params[:id])
      @page.set_key_value(params[:page][:key], params[:page][:value])
      if @page.save
        redirect_to admin_page_path(@page.id), notice: 'Page was successfully created.'
      else
        render action :create_data
      end
    end

    def new
      @page = Cavy::Page.new
    end

    def show
      @page = Cavy::Page.find(params[:id])
    end

    def create
      @page = Page.new(params[:page])
      @page.set_title params[:page][:title]
      if @page.save
        redirect_to admin_page_path(@page), notice: 'Page was successfully created.'
      else
        render action: 'new'
      end
    end

    def delete
      @page = Cavy::Page.find(params[:id])
      @page.destroy
      redirect_to admin_pages_path, notice: 'Page was successfully destroyed.'
    end

    def update
      @page = Cavy::Page.find(params[:id])
      @page_template = Cavy::PageTemplate.first
      @page.set_title params[:page][:title]
      @page.update_elements(params[:page][:page_elements], params[:locale])
      if @page.update_attributes(params[:page].except(:title, :page_elements))
        redirect_to admin_page_path(@page), flash: {success: 'Successfully updated page.'}
      else
        render action: 'edit'
      end
    end

    def edit
      @page = Cavy::Page.find(params[:id])
      @page_template = Cavy::PageTemplate.first
    end

    private

    def page_params
      # TODO Find a way to use hstore with strong parameters
      # params.require(:page).permit(:title, :render, :route, :tag_string, :description, :key, :value, :data)
    end

  end
end
