class Rating < ActiveRecord::Base

	belongs_to :item, dependent: :destroy,
    counter_cache: true
	belongs_to :user

	# EXAMPLES:
	# search: "delta"
	# search: "southwest"
	# search: "delta vs. southwest"
	# search: "delta versus southwest"
	# search: "deltaversussouthwest"
	# search: "deltavs.southwest"

	def self.filter_search_query(search_term, result=[])
		terms_that_mean_versus = [' versus ', ' versus', ' versus', ' vs ','versus',' vs.','vs.',' vs']
	  search_term = search_term.strip
		terms_that_mean_versus.each do |versus|
			if search_term.include?(versus)
				words = search_term.split(versus)
				words.each do |word|
					result << (word.strip)
				end
			end
		end
		return result.present? ? result.flatten.uniq : [search_term]
	end

	def self.search(search_term, result=[])
		params = filter_search_query(search_term)
		params.each do |query|
		result << Item.find_by_sql(["SELECT (AVG(x_rating)*100) AS xRating, (AVG(y_rating)*100)  AS yRating, COUNT(x_rating) AS votes, items.item_name, items.id, items.item_url, subcategories.subcategory_name FROM `items` JOIN items_subcategories ON items.id = items_subcategories.item_id JOIN `subcategories` ON subcategories.id = items_subcategories.subcategory_id JOIN `ratings` ON ratings.item_id = items.id WHERE subcategories.subcategory_name LIKE concat('%', ?, '%') OR items.item_name like concat('%', ?, '%') GROUP BY items.item_name LIMIT 10", query, query])
	  end
	  # byebug
	  return result.flatten
	end

	def rate_it 
		
	end


end
