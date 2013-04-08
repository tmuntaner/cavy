require_dependency "cavy/application_controller"

module Cavy
  class ItemsController < ApplicationController
    
    before_action :set_item, only: [:show, :edit, :update, :destroy]

    layout 'layouts/cavy/admin_layout'
    
    # GET /items
    def index
      @items = Item.all
    end

    # GET /items/1
    def show
    end

    # GET /items/new
    def new
      @item = Item.new
    end

    # GET /items/1/edit
    def edit
    end

    # POST /items
    def create
      @item = Item.new(params[:item])

      if @item.save
        redirect_to @item, notice: 'Item was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /items/1
    def update
      if @item.update(params[:item])
        redirect_to @item, notice: 'Item was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /items/1
    def destroy
      @item.destroy
      redirect_to items_url, notice: 'Item was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_item
        @item = Item.find(params[:id])
      end
  end
end
