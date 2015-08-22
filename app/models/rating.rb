class Rating < ActiveRecord::Base

	belongs_to :item
	belongs_to :user

	# EXAMPLES:
	# search: "delta"
	# search: "southwest"
	# search: "delta vs. southwest"
	# search: "delta versus southwest"
	# search: "deltaversussouthwest"
	# search: "deltavs.southwest"

	def self.filter_search_query(search_term, a=[])
		terms_that_mean_versus = [' versus ',' vs ','versus',' vs.','vs.',' vs']
		terms_that_mean_versus.each do |vs|
			a << search_term.split(vs) if search_term.include? vs
		end

		return a.present? ? a.flatten.uniq : [search_term]
	end

	def self.search(search_term, records=[])
		params = filter_search_query(search_term)
		params.each do |query|
		records << Item.find_by_sql(["SELECT (AVG(x_rating)*100) AS xRating, (AVG(y_rating)*100)  AS yRating, COUNT(x_rating) AS votes, items.item_name, items.id, items.item_url, subcategories.subcategory_name FROM `items` JOIN items_subcategories ON items.id = items_subcategories.item_id JOIN `subcategories` ON subcategories.id = items_subcategories.subcategory_id JOIN `ratings` ON ratings.item_id = items.id WHERE subcategories.subcategory_name LIKE concat('%', ?, '%') OR items.item_name like concat('%', ?, '%') GROUP BY items.item_name LIMIT 10", query, query])
	  end
	  return records.flatten
	end

	def position_of_vs_term_in_the_search
	end

	def is_a_subcategory
	end

	def get_draggable_balls(search_term)


	end

	def get_draggable_balls_text_ratings
	end

	def print_textratings_to_screen
	end

	def get_ball_coloring_in_textrating_area
	end

	def position_of_vs_term
	end

	def get_dollar_rating
	end

	def get_star_rating
	end




end
