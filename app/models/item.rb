class Item < ActiveRecord::Base

	has_and_belongs_to_many :subcategories
	has_many :ratings

	def tagcloud
	end


end
