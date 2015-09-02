class ItemsController < ApplicationController
  include ItemsSearchable
	layout 'application'

  def index
    @items = params[:search].present? ? Item.search(params[:search]) : []
    #search without a search term
    if params[:search].blank?
      flash.now[:alert] = "Please search for something (e.g. 'uber', 'uber vs. lyft', or 'airlines')."
    # search for a single item that does not exist in the db
    elsif @items.count == 0
      if user_signed_in?
        # add the item to the db
      elsif !user_signed_in?
       flash.now[:alert] = "One or more of your item(s) is not currently in our database. Please sign in to continue."
      end
    #search for a category with multiple items already in the db
    elsif Category.where("name LIKE ?", "%#{params[:search]}%").exists?
       return
    #search for multiple items, one or more of which does not exist in db
    elsif Item.filter_search_query(params[:search]).count != Item.search(params[:search]).count
       flash.now[:alert] = "One or more of your items is new to our system.  You must log in to complete this search."
    end
  end

  def create
    # @items = Item.search(params[:search])
    # @items.each do |item|
    #   next if Item.find_by_name(item.strip).exists?
    #   Item.create!(name: item.name)
    # end
  end

  def update
  end

  def destroy
  end


end
