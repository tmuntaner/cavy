require_dependency 'cavy/application_controller'

module Cavy
  class ItemSectionsController < ApplicationController

    before_action :set_item_section, only: [:show, :edit, :update, :destroy]
    layout 'cavy/admin_layout'

    def index
      @item_sections = ItemSection.all
    end

    def show
      @item_groups = if @item_section.item_groups.nil? then [] else Cavy::ItemGroup.find (@item_section.item_groups) end
    end

    def new
      @item_section = ItemSection.new
    end

    def edit
    end

    def create
      @item_section = ItemSection.new(title: item_section_params[:title], item_groups: params[:item_section][:item_groups])

      if @item_section.save
        redirect_to cavy_item_section_path(@item_section), notice: 'Item section was successfully created.'
      else
        render action: 'new'
      end
    end

    def update
      if @item_section.update(title: item_section_params[:title], item_groups: params[:item_section][:item_groups])
        redirect_to cavy_item_section_path(@item_section), notice: 'Item section was successfully updated.'
      else
        render action: 'edit'
      end
    end

    def destroy
      @item_section.destroy
      redirect_to cavy_item_sections_url, notice: 'Item section was successfully destroyed.'
    end

    private

    def set_item_section
      @item_section = ItemSection.find(params[:id])
    end

    def item_section_params
      params.require(:item_section).permit(:title)
    end
  end
end
