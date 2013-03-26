class CreateCavyUsers < ActiveRecord::Migration
  def change
    create_table :cavy_users do |t|
      t.string :email
      t.string :password_digest
      t.string :role
      t.string :auth_token
      t.timestamps
    end
  end
end
