class ChangeColumnNameSubcategory < ActiveRecord::Migration
  def change
  	rename_column :subcategories, :subcategory_name, :name
  	remove_column :subcategories, :subcategory_factor
  end
end
