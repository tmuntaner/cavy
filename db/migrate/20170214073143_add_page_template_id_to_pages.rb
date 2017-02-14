class AddPageTemplateIdToPages < ActiveRecord::Migration[5.0]
  def change
    change_table :cavy_pages do |t|
      t.integer :cavy_page_template_id
    end

    add_foreign_key :cavy_pages, :cavy_page_templates
  end
end
