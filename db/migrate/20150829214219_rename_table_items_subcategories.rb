class RenameTableItemsSubcategories < ActiveRecord::Migration
  def change
    rename_table :items_subcategories, :items_categories
  end
end
