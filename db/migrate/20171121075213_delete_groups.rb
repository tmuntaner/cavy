class DeleteGroups < ActiveRecord::Migration[5.1]
  def change
    drop_table :cavy_groups
    drop_table :cavy_policies
  end
end
