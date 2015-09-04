class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.integer :fb_id
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :image
      t.string :gender
      t.timestamps null: false
    end
  end

  def down
    drop_table :users
  end
end
