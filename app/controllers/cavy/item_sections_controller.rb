require_dependency "cavy/application_controller"

module Cavy
  class ItemSectionsController < ApplicationController
    before_action :set_item_section, only: [:show, :edit, :update, :destroy]

    layout 'cavy/admin_layout'

    # GET /item_sections
    def index
      @item_sections = ItemSection.all
    end

    # GET /item_sections/1
    def show
      @item_groups =  Cavy::ItemGroup.find ( @item_section.item_groups )
    end

    # GET /item_sections/new
    def new
      @item_section = ItemSection.new
    end

    # GET /item_sections/1/edit
    def edit
    end

    # POST /item_sections
    def create
      @item_section = ItemSection.new( title: item_section_params[:title], item_groups: params[:item_section][:item_groups] )

      if @item_section.save
        redirect_to cavy_item_section_path(@item_section), notice: 'Item section was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /item_sections/1
    def update
      if @item_section.update( title: item_section_params[:title], item_groups: params[:item_section][:item_groups] )
        redirect_to cavy_item_section_path(@item_section), notice: 'Item section was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /item_sections/1
    def destroy
      @item_section.destroy
      redirect_to cavy_item_sections_url, notice: 'Item section was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_item_section
        @item_section = ItemSection.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def item_section_params
        params.require(:item_section).permit(:title)
      end
  end
end
