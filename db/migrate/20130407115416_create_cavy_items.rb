class CreateCavyItems < ActiveRecord::Migration
  def change
    create_table :cavy_items do |t|
      t.string :name
      t.hstore :data

      t.timestamps
    end
  end
end
