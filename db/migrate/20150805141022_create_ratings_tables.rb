class CreateRatingsTables < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rating_id
      t.integer :user_id
      t.integer :item_id
      t.decimal :x_rating, precision: 10, scale: 3
      t.decimal :y_rating, precision: 10, scale: 3
      t.text :text_rating
      t.timestamps null: false
    end
  end
end
