require_dependency "cavy/application_controller"

module Cavy
  class AdminItemGroupsController < ApplicationController
    
    before_action :set_admin_item_group, only: [:show, :edit, :update, :destroy]

    layout 'layouts/cavy/admin_layout'
    
    # GET /admin_item_groups
    def index
      @admin_item_groups = AdminItemGroup.all
    end

    # GET /admin_item_groups/1
    def show
      @items = @admin_item_group.items
    end

    # GET /admin_item_groups/new
    def new
      @admin_item_group = AdminItemGroup.new
    end

    # GET /admin_item_groups/1/edit
    def edit
    end

    # POST /admin_item_groups
    def create
      @admin_item_group = AdminItemGroup.new(admin_item_group_params)

      if @admin_item_group.save
        redirect_to @admin_item_group, notice: 'Admin item group was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /admin_item_groups/1
    def update
      if @admin_item_group.update(admin_item_group_params)
        redirect_to @admin_item_group, notice: 'Admin item group was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /admin_item_groups/1
    def destroy
      @admin_item_group.destroy
      redirect_to admin_item_groups_url, notice: 'Admin item group was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_admin_item_group
        @admin_item_group = AdminItemGroup.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def admin_item_group_params
        params.require(:admin_item_group).permit(:title, :param_string)
      end
  end
end
