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
        redirect_to admin_edit_page_path(@page.id), flash: { success: 'Page was successfully created.' }
      else
        render action :create_data
      end
    end

    def new
      @page = Cavy::Page.new
    end

    def create
      @page = Page.new(params[:page])
      @page.set_title params[:page][:title]
      if @page.save
        redirect_to admin_edit_page_path(@page), flash: { success: 'Page was successfully created.' }
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
      if @page.update_page(page_params, params[:locale])
        redirect_to admin_edit_page_path(@page), flash: { success: 'Successfully updated page.' }
      else
        render action: 'edit'
      end
    end

    def edit
      @page = Cavy::Page.find(params[:id])
    end

    private

    def page_params
      params.require(:page).permit(:title, :page_elements, :cavy_page_template_id, :route, :tag_string, :seo_description_string).tap do |whitelisted|
        whitelisted[:page_elements] = params[:page][:page_elements]
        whitelisted[:title] = params[:page][:title]
      end
    end

  end
end
