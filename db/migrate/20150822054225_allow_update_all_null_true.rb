class AllowUpdateAllNullTrue < ActiveRecord::Migration
  def change
		change_column :categories_subcategories, :updated_at, :datetime, :null => true
		change_column :items, :updated_at, :datetime, :null => true
		change_column :items_subcategories, :updated_at, :datetime, :null => true
		change_column :ratings, :updated_at, :datetime, :null => true
		change_column :subcategories, :updated_at, :datetime, :null => true 
		change_column :users, :updated_at, :datetime, :null => true
  end
end
