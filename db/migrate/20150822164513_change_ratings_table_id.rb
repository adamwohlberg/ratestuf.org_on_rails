class ChangeRatingsTableId < ActiveRecord::Migration
  def change
    remove_column :ratings, :rating_id
  end
end
