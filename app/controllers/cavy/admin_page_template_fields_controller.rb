require_dependency 'cavy/application_controller'

module Cavy
  class AdminPageTemplateFieldsController < ApplicationController
    layout 'cavy/admin_layout'

    def create
      field_params = page_template_params
      @page_template = Cavy::PageTemplate.find(params[:id])
      @page_template.add_field(field_params[:name], field_params[:type])

      redirect_to admin_edit_page_template_path(@page_template.id), flash: { success: 'Page template fields were successfully updated.' }
    end

    def delete
      @page_template = Cavy::PageTemplate.find(params[:id])
      @page_template.remove_field(params[:field])

      redirect_to admin_edit_page_template_path(@page_template.id), flash: { ssuccess: 'Page Template field was deleted.' }
    end

    private

    def page_template_params
      params.require(:page_template).permit(:name, :type)
    end
  end
end
