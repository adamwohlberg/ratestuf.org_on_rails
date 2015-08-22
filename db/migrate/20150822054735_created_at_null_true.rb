class CreatedAtNullTrue < ActiveRecord::Migration
  def change
		change_column :categories_subcategories, :created_at, :datetime, :null => true
		change_column :items, :created_at, :datetime, :null => true
		change_column :items_subcategories, :created_at, :datetime, :null => true
		change_column :ratings, :created_at, :datetime, :null => true
		change_column :subcategories, :created_at, :datetime, :null => true 
		change_column :users, :created_at, :datetime, :null => true
  end
end
