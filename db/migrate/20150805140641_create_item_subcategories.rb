class CreateItemSubcategories < ActiveRecord::Migration
  def change
    create_table :items_subcategories, id: false do|t|
      t.integer :item_id
      t.integer :subcategory_id
      t.timestamps null: false
    end
    add_index :items_subcategories, [:item_id, :subcategory_id]
  end
end
