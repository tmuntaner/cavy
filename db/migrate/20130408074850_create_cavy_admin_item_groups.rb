class CreateCavyAdminItemGroups < ActiveRecord::Migration
  def change
    create_table :cavy_admin_item_groups do |t|
      t.string :title
      t.string :params, array: true
      t.timestamps
    end
  end
end
