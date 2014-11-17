class AddItemGroups < ActiveRecord::Migration
  def change
    create_table :cavy_item_groups do |t|
      t.string  :title
      t.string  :params, array: true
    end
    change_table :cavy_items do |t|
      t.belongs_to :item_group
    end
  end
end
