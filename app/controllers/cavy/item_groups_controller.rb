require_dependency "cavy/application_controller"

module Cavy
  class ItemGroupsController < ApplicationController
    
    before_action :set_item_group, only: [:show, :edit, :update, :destroy]

    layout 'cavy/admin_layout'
    
    # GET /item_groups
    def index
      @item_groups = ItemGroup.all
    end

    # GET /item_groups/1
    def show
      @items = @item_group.items
    end

    # GET /item_groups/new
    def new
      @item_group = ItemGroup.new
    end

    # GET /item_groups/1/edit
    def edit
    end

    # POST /item_groups
    def create
      @item_group = ItemGroup.new(item_group_params)

      if @item_group.save
        redirect_to cavy_item_group_path(@item_group), notice: 'Admin item group was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /item_groups/1
    def update
      if @item_group.update(item_group_params)
        redirect_to cavy_item_group_path(@item_group), notice: 'Admin item group was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /item_groups/1
    def destroy
      @item_group.destroy
      redirect_to item_groups_url, notice: 'Admin item group was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_item_group
        @item_group = ItemGroup.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def item_group_params
        params.require(:item_group).permit(:title, :param_string)
      end
  end
end
