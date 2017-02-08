require_dependency 'cavy/application_controller'

module Cavy
  class AdminPageTemplatesController < ApplicationController

    layout 'cavy/admin_layout'

    def index
      @page_templates = Cavy::PageTemplate.all
    end

    def new
      @page_template = Cavy::PageTemplate.new
    end

    def show
      @page_template = Cavy::PageTemplate.find(params[:id])
      #@page_template.fields = {title: 'string', content: 'text'}
      #@page_template.save
    end

    def create
      @page_template = Cavy::PageTemplate.new(page_template_params)
      if @page_template.save
        redirect_to admin_page_templates_path, notice: 'Page Template was successfully created.'
      else
        render action: 'new'
      end
    end

    def edit
      @page_template = Cavy::PageTemplate.find(params[:id])
    end

    def update
      @page_template = Cavy::PageTemplate.find(params[:id])

      if @page_template.update(page_template_params)
        redirect_to admin_page_templates_path, notice: 'Page Template was successfully updated.'
      else
        render action: 'edit'
      end
    end

    def delete
      @page_template = Cavy::PageTemplate.find(params[:id])
      @page_template.destroy
      redirect_to admin_page_templates_path, notice: 'Page Template was successfully destroyed.'
    end

    private

    def page_template_params
      params.require(:page_template).permit(:name, :template)
    end

  end
end