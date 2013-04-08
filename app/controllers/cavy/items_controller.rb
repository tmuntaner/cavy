require_dependency "cavy/application_controller"

module Cavy
  class ItemsController < ApplicationController
    
    before_action :set_item, only: [:show, :edit, :update, :destroy]
    before_action :set_group, only: [:create,:update]

    layout 'layouts/cavy/admin_layout'

    # GET /items/1
    def show
    end

    # GET /items/new
    def new
      @group = Cavy::AdminItemGroup.find(params[:group_id])
      @item = Item.new
      @item.create_params(@group.title,@group.params)
    end

    # GET /items/1/edit
    def edit
    end

    # POST /items
    def create
      @item = Item.new(params[:item])

      if @item.save
        redirect_to admin_item_group_path(params[:group_id]), notice: 'Item was successfully created.'
      end
    end

    # PATCH/PUT /items/1
    def update
      if @item.update(params[:item])
        redirect_to cavy_item_path(@item.id), notice: 'Item was successfully updated.'
      end
    end

    # DELETE /items/1
    def destroy
      @item.destroy
      redirect_to cavy_items_path, notice: 'Item was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_item
        @item = Item.find(params[:id])
      end

      def set_group
        if @item
          params['item']['data']['type'] = @item.data['type']
        else
          params['item']['data']['type'] = Cavy::AdminItemGroup.find(params[:group_id]).type
        end
      end

  end
end
