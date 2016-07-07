require_dependency 'cavy/application_controller'

module Cavy
  class ItemGroupsController < ApplicationController

    before_action :set_item_group, only: [:show, :edit, :update, :destroy]
    layout 'cavy/admin_layout'

    def index
      @item_groups = ItemGroup.all
    end

    def show
      @items = @item_group.items.order('position asc')
    end

    def new
      @item_group = ItemGroup.new
    end

    def edit
    end

    def create
      @item_group = ItemGroup.new(item_group_params)

      if @item_group.save
        redirect_to cavy_item_group_path(@item_group), notice: 'Admin item group was successfully created.'
      else
        render action: 'new'
      end
    end

    def update
      if @item_group.update_attributes(item_group_params)
        redirect_to cavy_item_group_path(@item_group), notice: 'Admin item group was successfully updated.'
      else
        render action: 'edit'
      end
    end

    def update_order
      params[:item].each_with_index do |id, index|
        Cavy::Item.find(id).set(position: index+1)
      end
      render nothing: true
    end

    def destroy
      @item_group.destroy
      redirect_to item_groups_url, notice: 'Admin item group was successfully destroyed.'
    end

    private

    def set_item_group
      @item_group = ItemGroup.find(params[:id])
    end

    def item_group_params
      params.require(:item_group).permit(:title, :param_string)
    end
  end
end
