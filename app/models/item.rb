class Item < ActiveRecord::Base

	has_and_belongs_to_many :subcategories
	has_many :ratings

	def popular_items
		popular_items = Item.joins(:ratings).group(:item_name).count("ratings.id").sort_by {|k,v| v}.reverse

		percent = ((item.ratings.count / Rating.count) * 100).floor 
		# case percent
		# when percent < 20
		#   class = 'smallest'
		# when percent >= 20 && percent < 40
		#   class = 'small'		  
		# when percent >= 40 && percent < 60
		#   class = 'medium'	
		# when percent >= 60 && percent < 90
		#   class = 'large'	
		# when percent >= 80 && percent < 100
		#   class = 'largest'			  
		# end

		@popular = @items.where()
	end
end
