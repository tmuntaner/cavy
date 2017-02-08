class CreateCavyPageTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :cavy_page_templates do |t|
      t.string :name
      t.string :template
      t.hstore :fields

      t.timestamps
    end
  end
end
