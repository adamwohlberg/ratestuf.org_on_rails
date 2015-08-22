class DropItemsSubcategories < ActiveRecord::Migration
  def change
  	drop_table :items_subcategories
  end
end
