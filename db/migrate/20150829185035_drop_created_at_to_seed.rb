class DropCreatedAtToSeed < ActiveRecord::Migration
  def change
    remove_column :items_subcategories, :created_at, :datetime
    remove_column :items_subcategories, :updated_at
  end
end
