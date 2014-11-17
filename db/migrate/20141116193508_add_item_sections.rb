class AddItemSections < ActiveRecord::Migration
  def change
    create_table :cavy_item_sections do |t|
      t.string  :title
      t.integer :item_groups, array: true
    end
  end
end
