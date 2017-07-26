class AddItems < ActiveRecord::Migration[4.2]
  def change
    create_table :cavy_items do |t|
      t.hstore  :data
      t.integer :position
    end
  end
end
