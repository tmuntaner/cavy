class AddUserPolicies < ActiveRecord::Migration[5.0]
  def change
    create_table :cavy_groups do |t|
      t.string :name
      t.boolean :is_super_admin
      t.timestamps
    end
    add_index :cavy_groups, :name, unique: true

    create_table :cavy_policies do |t|
      t.string :name
    end
    add_index :cavy_policies, :name, unique: true

    create_join_table :cavy_users, :cavy_groups
    create_join_table :cavy_groups, :cavy_policies
  end
end
