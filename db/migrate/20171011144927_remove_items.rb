class RemoveItems < ActiveRecord::Migration[5.1]
  def change
    drop_table :cavy_item_sections
    drop_table :cavy_item_groups
    drop_table :cavy_items
  end
end
