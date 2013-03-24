class CreateCavyPages < ActiveRecord::Migration
  def change
    create_table :cavy_pages do |t|
      t.string :content
      t.string :title
      t.string :render
      t.timestamps
    end
  end
end
