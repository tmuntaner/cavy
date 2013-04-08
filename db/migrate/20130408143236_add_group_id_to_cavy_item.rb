class AddGroupIdToCavyItem < ActiveRecord::Migration
  def change
    add_column :cavy_items, :group_id, :integer
    remove_column :cavy_items, :name
  end
end
