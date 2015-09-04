class FirstRatingHackToSetDefaultToPointFive < ActiveRecord::Migration
  def change
    change_column :ratings, :x_rating, :decimal, precision: 10, scale: 3, default: 0.50
    change_column :ratings, :y_rating, :decimal, precision: 10, scale: 3, default: 0.50
  end
end
