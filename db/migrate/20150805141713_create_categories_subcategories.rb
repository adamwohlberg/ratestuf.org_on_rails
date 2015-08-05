class CreateCategoriesSubcategories < ActiveRecord::Migration
  def change
    create_table :categories_subcategories, :id => false do |t|
    	t.integer :category_id
    	t.integer :subcategory_id
      t.timestamps null: false
    end
    add_index :categories_subcategories, [:category_id, :subcategory_id], 
          :unique => true, :name => 'subcategory_category_index'
  end
end
