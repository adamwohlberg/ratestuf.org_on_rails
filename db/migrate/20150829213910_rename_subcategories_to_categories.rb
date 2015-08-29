class RenameSubcategoriesToCategories < ActiveRecord::Migration
  def change
  	rename_table :subcategories, :categories  
  	remove_column :categories, :category_id
  end
end
