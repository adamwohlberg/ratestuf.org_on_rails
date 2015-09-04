class UpdateJoinTableNameAndIndex < ActiveRecord::Migration
  def change
  	rename_table 'items_categories', 'categories_items'
  	rename_index :categories_items, 'item_category_index', 'category_item_index'
  end
end
