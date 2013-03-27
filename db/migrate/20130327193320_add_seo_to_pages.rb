class AddSeoToPages < ActiveRecord::Migration
  def change
    execute "create extension hstore"

    add_column :cavy_pages, :description, :text
    add_column :cavy_pages, :tags, :string, array: true
    add_column :cavy_pages, :page_elements, :hstore
  end
end
