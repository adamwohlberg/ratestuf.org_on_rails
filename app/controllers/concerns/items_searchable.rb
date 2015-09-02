module ItemsSearchable
extend ActiveSupport::Concern
	PLEASE_SEARCH =  "Please search for something "\
		"(e.g. 'uber', 'uber vs. lyft', or 'airlines')."
	NEW_ITEM = "One or more of your items is new to our system.  "\
		"You must log in to complete this search."
	SIGN_IN = "One or more of your item(s) is not currently in our database. "\
		"Please sign in to continue."

	def search(search_string)
		@search_string = search_string
		set_items
		case 
		when @search_string.blank? then PLEASE_SEARCH 
		when should_add_item?
	    # add the item to the db		
		when should_sign_in? then SIGN_IN
		when category_exists?
		when new_item? then NEW_ITEM
		end	
	end

	private

	def set_items
		return @items = [] if @search_string.blank?
		@items = Item.search(@search_string) 
	end

	def category_exists?
		Category.where("name LIKE ?", "%#{@search_string}%").exists?
	end

	def new_item?
		Item.filter_search_query(@search_string).count != 
		Item.search(@search_string).count	
	end

	def should_add_item?
		@items.count.zero? && user_signed_in?
	end

	def should_sign_in?
		@items.count.zero? && !user_signed_in?
	end

end