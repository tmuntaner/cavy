class AddPagesTable < ActiveRecord::Migration[4.2]
  def change
    create_table :cavy_pages do |t|
      t.hstore  :title
      t.hstore  :content
      t.hstore  :data
      t.string  :render
      t.string  :route
      t.text    :description
      t.string  :tags, array: true
      t.json    :page_elements
    end
  end
end
