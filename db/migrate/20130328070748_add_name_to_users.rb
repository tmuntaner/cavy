class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :cavy_users, :name, :string
  end
end
