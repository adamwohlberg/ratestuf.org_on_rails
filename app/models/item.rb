class Item < ActiveRecord::Base

	has_many :items_categories
	has_many :categories, through: :items_categories
	has_many :ratings

end
