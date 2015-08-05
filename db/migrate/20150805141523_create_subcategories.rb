class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
    	t.string :subcategory_name
    	t.string :subcategory_factor
      t.timestamps null: false
    end
  end
end
