class RatingsController < ApplicationController

	layout 'application'

  def index
    @items = Item.all
  	search
    @popular_items = Item.joins(:ratings).group(:item_name).count("ratings.id") 
  end

  def search
		@items = params[:search].present? ? Rating.search(params[:search]) : []
  end

  def create
  	if Rating.save
    flash[:notice] = "Congratulations. Your rating was successfully saved."
  	end
  end

  def update
  end

  def destroy
  end

end
