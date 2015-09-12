module ItemsSearchable
extend ActiveSupport::Concern
	PLEASE_SEARCH_FOR_SOMETHING =  "Please search for something (e.g. 'uber', 'uber vs. lyft', or 'airlines') to rate."
	ITEM_ADDED = "Your new item(s) are now added to our database. Thanks!"
	TOO_MANY_ITEMS = "You have created too many items. Please contact us to join our rating team!"
	NEW_ITEM_PLEASE_SIGN_IN = "One or more of your items is new to our system. You must log in to complete this search."

	def search(search_string)
			@search_string = search_string
			set_items
			case 
			when @search_string.blank? then PLEASE_SEARCH_FOR_SOMETHING
			when single_search_term_which_is_a_category?
			when user_has_created_too_many_items? then TOO_MANY_ITEMS
			when should_add_item?
				create_item_and_associated_records
    		redirect_to root_path(search: search_string), notice: ITEM_ADDED
			when new_item_but_not_signed_in? then NEW_ITEM_PLEASE_SIGN_IN
			end	
	end

	private

	def set_items
			return @items = [] if @search_string.blank?
			@items = Item.search(@search_string)
	end

	def single_search_term_which_is_a_category?
			Category.where("name LIKE ?", "%#{@search_string}%").exists?
	end

	def new_item_but_not_signed_in?
			# user not signed in and the count of items in the search is not equal to the count of items in the database
			!user_signed_in? && (Item.filter_search_query(@search_string).count > Item.search(@search_string).count)	
	end

	def should_add_item?
			user_signed_in? && @items.count.zero? || 
			user_signed_in? && contains_a_new_item? 
	end

	def create_item_and_associated_records
	  	ItemFactory.create!(@search_string)
	end

	def user_has_created_too_many_items?
			current_user && (Item.where(user_id: current_user.id).count > 50)
	end

	def contains_a_new_item?
		Item.filter_search_query(@search_string).each do |item|
			return false if Item.where(name: "#{item}").exists?
			return false if Category.where("name LIKE ?", "%#{item}%").exists?	
		  true
		end
	end


end