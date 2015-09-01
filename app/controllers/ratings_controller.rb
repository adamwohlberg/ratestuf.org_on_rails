class RatingsController < ApplicationController

	layout 'application'

  def index
  	search
    @popular_items = Item.joins(:ratings).group(:name).count("ratings.id") 
  end

  def search
		@items = params[:search].present? ? Rating.search(params[:search]) : []
  end

  def create
    @items = params[:search].present? ? Rating.search(params[:search]) : []
    if user_signed_in?
      @items.each do |item|
        # instantiate a new object
        @rating = Rating.create!(:item_id => item.id, :x_rating => item.x_rating, :y_rating => item.y_rating)
    # save the object
        if @rating.save
          # if save succeeds, redirect to the index action with a success method
          redirect_to :root_path
          flash[:notice] = "Congratulations. Your rating was successfully saved."
        else
          # if save fails, redisplay 
          redirect_to :root_path
          flash[:notice] = "Something went wrong. Please try again later." 
        end
      end     
    else
      # if user is not signed in
      flash[:notice] = "Please log in first."
    end
  end

  def update
  end

  def destroy
  end

end
