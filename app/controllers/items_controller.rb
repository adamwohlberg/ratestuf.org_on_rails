class ItemsController < ApplicationController

	layout 'application'

  def index
    @items = params[:search].present? ? Item.search(params[:search]) : []
    if params[:search].blank?
      flash.now[:alert] = "Please search for something (e.g. 'uber', 'uber vs. lyft', or 'airlines')."
    # search for a single item that does not exist in the db
    elsif @items.count == 0
       flash.now[:alert] = "This item does not exist in our database yet.  You must log in or try another search term."
    #search for a category with multiple items already in the db
    elsif Category.where("name LIKE ?", "%#{params[:search]}%").exists?
       return
    #search for multiple items, one or more of which does not exist in db
    elsif Item.filter_search_query(params[:search]).count != Item.search(params[:search]).count
       flash.now[:alert] = "One or more of your items is new to our system.  You must log in to continue this search."
    end
  end

  def create
    if !params[:search].present? 
      flash[:alert] = "Please search for something (e.g. 'uber', 'uber vs. lyft', or 'airlines')."
    else

    # @items = params[:search].present? ? Rating.search(params[:search]) : []
    #   @items.each do |item|
    #     next if Item.find_by_name(item.strip).exists?
    #     if !user_signed_in? 
    #        redirect_to :root
    #        flash[:alert] = "One or more of your item(s) is not currently in our database. Please sign in to continue."
    #     end
    #     Item.create!()

    #   end
  # end






      flash[:alert] = ""
      add_new_items    
		  @items = params[:search].present? ? Item.search(params[:search]) : []
    end
  end

  def update
  end

  def destroy
  end

  private 

  def add_new_items
    @items = Item.search(params[:search])
    @items.each do |item|
      next if Item.find_by_name(item.strip).exists?
      if !user_signed_in? 
         redirect_to :root
         flash[:alert] = "One or more of your item(s) is not currently in our database. Please sign in to continue."
      else
        Item.create!(name: item.name)
      end
    end
  end



end
