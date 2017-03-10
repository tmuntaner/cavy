class CleanupPages < ActiveRecord::Migration[5.0]
  def change
    remove_column :cavy_pages, :description
    remove_column :cavy_pages, :tags
    remove_column :cavy_pages, :content
    add_column :cavy_pages, :seo_description, :hstore
    add_column :cavy_pages, :seo_keywords, :jsonb
  end
end
