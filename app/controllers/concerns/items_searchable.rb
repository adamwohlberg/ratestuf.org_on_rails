module ItemsSearchable
extend ActiveSupport::Concern

	def search(search_string)
    @items = search_string.present? ? Item.search(search_string) : []
    #search without a search term
    if search_string.blank?
      return "Please search for something (e.g. 'uber', 'uber vs. lyft', or 'airlines')."
    # search for a single item that does not exist in the db
    elsif @items.count == 0
      if user_signed_in?
        # add the item to the db
      elsif !user_signed_in?
       return "One or more of your item(s) is not currently in our database. Please sign in to continue."
      end
    #search for a category with multiple items already in the db
    elsif Category.where("name LIKE ?", "%#{search_string}%").exists?
       return
    #search for multiple items, one or more of which does not exist in db
    elsif Item.filter_search_query(search_string).count != Item.search(search_string).count
       return "One or more of your items is new to our system.  You must log in to complete this search."
    end		
	end

end