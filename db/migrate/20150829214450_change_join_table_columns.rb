class ChangeJoinTableColumns < ActiveRecord::Migration
  def change
    rename_column :items_categories, :subcategory_id, :category_id
  end
end
