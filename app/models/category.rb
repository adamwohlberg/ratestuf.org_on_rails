class Category < ActiveRecord::Base
  has_many :categories_items
  has_and_belongs_to_many :items, join_table: :categories_items
end
