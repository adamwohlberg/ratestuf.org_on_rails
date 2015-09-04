class UpdateIndex < ActiveRecord::Migration
  def change
    rename_index :items_categories, 'item_subcategory_index', 'item_category_index'
  end
end
