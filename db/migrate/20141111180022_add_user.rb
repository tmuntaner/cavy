class AddUser < ActiveRecord::Migration
  def change
    create_table :cavy_users do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.string :auth_token
      t.string :role
 
      t.timestamps null: false
    end
  end
end
