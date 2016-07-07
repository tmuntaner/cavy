require_dependency 'cavy/application_controller'

module Cavy
  class ItemsController < ApplicationController

    before_action :set_item, only: [:show, :edit, :update, :destroy]
    before_action :set_group, only: [:create, :update]

    layout 'cavy/admin_layout'

    def show
    end

    def new
      @group = Cavy::ItemGroup.find_by(id: params[:group_id])
      @item = @group.items.new
      @item.create_params(@group.title, @group.params)
    end

    def edit
    end

    def create
      @group = Cavy::ItemGroup.find_by(id: params[:group_id])
      @item = @group.items.create(params[:item])

      if @item.save
        redirect_to cavy_item_group_path(params[:group_id]), notice: 'Item was successfully created.'
      end
    end

    def update
      if @item.update_attributes(params[:item])
        redirect_to cavy_item_path(@item.id), notice: 'Item was successfully updated.'
      end
    end

    def destroy
      @item.destroy
      redirect_to :back, notice: 'Item was successfully destroyed.'
    end

    private

    def set_item
      @item = Item.find(params[:id])
    end

    def set_group
      if @item
        params['item']['data']['type'] = @item.data['type']
      else
        params['item']['data']['type'] = Cavy::ItemGroup.find(params[:group_id]).type
      end
    end

  end
end
