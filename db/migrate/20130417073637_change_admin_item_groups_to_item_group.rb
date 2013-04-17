class ChangeAdminItemGroupsToItemGroup < ActiveRecord::Migration
  def up
    rename_table :cavy_admin_item_groups, :cavy_item_groups
  end

  def down
    rename_table :cavy_item_groups, :cavy_admin_item_groups
  end
end
