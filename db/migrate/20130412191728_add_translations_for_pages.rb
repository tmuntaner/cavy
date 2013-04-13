class AddTranslationsForPages < ActiveRecord::Migration
  def up
    Cavy::Page.create_translation_table!({
      :title => :string,
      :content => :text
    }, {
      :migrate_data => true
    })
  end

  def down
    Cavy::Page.drop_translation_table! :migrate_data => true
  end
end
