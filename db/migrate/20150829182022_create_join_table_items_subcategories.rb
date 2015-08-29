class CreateJoinTableItemsSubcategories < ActiveRecord::Migration
  def change
    create_table :items_subcategories do |t|
    	t.integer :item_id
    	t.integer :subcategory_id
      t.timestamps null: false
    end
    add_index :items_subcategories, [:item_id, :subcategory_id], 
          :unique => true, :name => 'item_subcategory_index'
  end
end
