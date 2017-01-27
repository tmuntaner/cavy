# This migration comes from cavy (originally 20141116191811)
class AddItems < ActiveRecord::Migration
  def change
    create_table :cavy_items do |t|
      t.hstore  :data
      t.integer :position
    end
  end
end
