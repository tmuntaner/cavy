# This migration comes from cavy (originally 20141114191059)
class AddHstore < ActiveRecord::Migration
  def up
    execute 'CREATE EXTENSION hstore'
  end

  def down
    execute 'DROP EXTENSION hstore'
  end
end
