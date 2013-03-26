class AddRouteToCavyPages < ActiveRecord::Migration
  def change
    add_column :cavy_pages, :route, :string
  end
end
