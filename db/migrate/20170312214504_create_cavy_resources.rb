class CreateCavyResources < ActiveRecord::Migration[5.0]
  def change
    create_table :cavy_resources do |t|
      t.string :url
      t.string :name
      t.string :file_type

      t.timestamps
    end
    add_index :cavy_resources, :url, unique: true
  end
end
