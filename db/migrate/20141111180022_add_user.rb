class AddUser < ActiveRecord::Migration[4.2]
  def change
    create_table :cavy_users do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.string :auth_token
      t.string :role
 
      t.timestamps
    end
  end
end
