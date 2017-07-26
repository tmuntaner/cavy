require_dependency 'cavy/application_controller'

module Cavy
  class ItemsController < ApplicationController

    layout 'cavy/admin_layout'

    def edit
      @item_section = ItemSection.find(params[:item_section_id])
      @item_groups = ItemGroup.find(@item_section.item_groups.to_a)
    end

    def create
      @group = Cavy::ItemGroup.find_by(id: params[:group_id])
      @item = @group.items.create(params[:item])

      if @item.save
        redirect_to cavy_item_group_path(params[:group_id]), notice: 'Item was successfully created.'
      end
    end

    def update
      item_section = ItemSection.find(params[:item_section_id])
      item_group = ItemGroup.find(params[:item_group_id])
      remove_items = params['remove_item_' + params[:item_group_id]].to_s.split(',')

      remove_items.each do |id|
        item = Item.find(id)
        item.destroy if item.item_group_id == item_group.id
      end

      get_item_params.try(:each) do |id, item_params|
        is_empty = item_params.values.inject(false) {|empty_check, value| empty_check = empty_check || value.to_s == ''}
        if id.to_i.to_s == id.to_s
          item = Item.find id
          item.update_attributes(data: item_params)
        elsif !is_empty
          item = item_group.items.create(data: item_params)
          item.save
        end
      end

      redirect_to cavy_edit_items_path(item_section_id: item_section.id), notice: 'Items were updated.'
    end

    def destroy
      @item.destroy
      redirect_to :back, notice: 'Item was successfully destroyed.'
    end

    private

    def get_item_params
      params.require(:item)
    end

  end
end
