class AddNewUsersTable < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.timestamps null: false
    end
  end

  def down
  	drop_table :users
  end
end
