class ChangeContentColumnInCavyPagesFromStringToText < ActiveRecord::Migration
  def change
    change_column :cavy_pages, :content, :text
  end
end
