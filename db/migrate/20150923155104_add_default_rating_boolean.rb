class AddDefaultRatingBoolean < ActiveRecord::Migration
  def change
  	add_column :ratings, :default_rating, :boolean, :default => false
  end
end
