class CreateCavyItemSections < ActiveRecord::Migration
  def change
    create_table :cavy_item_sections do |t|
      t.string :title
      t.timestamps
    end
  end
end
