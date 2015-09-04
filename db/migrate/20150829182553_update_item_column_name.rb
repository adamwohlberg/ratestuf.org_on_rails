class UpdateItemColumnName < ActiveRecord::Migration
  def change
    rename_column :items, :item_name, :name
    rename_column :items, :item_url, :url
  end
end
