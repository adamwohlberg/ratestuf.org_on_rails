module ItemsSearchable
extend ActiveSupport::Concern
	PLEASE_SEARCH =  "Please search for something "\
		"(e.g. 'uber', 'uber vs. lyft', or 'airlines')."
	NEW_ITEM_PLEASE_SIGN_IN = "One or more of your items is new to our system.  "\
		"You must log in to complete this search."
	SIGN_IN = "One or more of your item(s) is not currently in our database. "\
		"Please sign in to continue."
	ITEM_ADDED = "Your new item was added to our database."
	TOO_MANY_ITEMS = "You have created too many items."

	def search(search_string)
		@search_string = search_string
		set_items
		case 
		when @search_string.blank? then PLEASE_SEARCH 
		when user_has_created_too_many_items? then TOO_MANY_ITEMS
		when should_add_item?
			create_item_and_associated_objects
			ITEM_ADDED
			redirect_to :root
		when category_exists?
		when new_item_but_not_signed_in? then NEW_ITEM_PLEASE_SIGN_IN
		when should_sign_in? then SIGN_IN
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

	def new_item_but_not_signed_in?
		!user_signed_in? && (Item.filter_search_query(@search_string).count != Item.search(@search_string).count)	
	end

	def should_add_item?
		(@items.count.zero? && user_signed_in?) || (user_signed_in? && (Item.filter_search_query(@search_string).count != Item.search(@search_string).count))
	end

	def should_sign_in?
		@items.count.zero? && !user_signed_in?
	end

	def create_item_and_associated_objects
	  ItemFactory.create!(@search_string)
	end

	def user_has_created_too_many_items?
		current_user && (Item.where(user_id: current_user.id).count > 100)
	end

end