class Item < ActiveRecord::Base

	has_and_belongs_to_many :subcategories

	def tagcloud
	end


end
