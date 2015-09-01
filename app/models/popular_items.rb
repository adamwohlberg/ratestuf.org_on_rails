class PopularItems
	# this object has one responsibility to make that query

	def tag_cloud_class(item)
		@tag_cloud_items = Item.joins(:ratings).group(:name).count("ratings.id").sort_by {|k,v| v}.reverse
		percent = ((item.ratings.count / Rating.all.count) * 100).floor 
		case percent
		when percent < 20
		  class = 'smallest'
		when percent >= 20 && percent < 40
		  class = 'small'		  
		when percent >= 40 && percent < 60
		  class = 'medium'	
		when percent >= 60 && percent < 90
		  class = 'large'	
		when percent >= 80 && percent < 100
		  class = 'largest'			  
		end
	end

	end




end