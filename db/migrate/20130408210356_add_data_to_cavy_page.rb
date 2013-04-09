class AddDataToCavyPage < ActiveRecord::Migration
  def change
    add_column :cavy_pages, :data, :hstore
  end
end
