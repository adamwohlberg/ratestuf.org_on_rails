class AddCategoryIdToSubcategory < ActiveRecord::Migration
  def change
    drop_table :categories_subcategories
    add_column :subcategories, :category_id, :integer
  end
end
