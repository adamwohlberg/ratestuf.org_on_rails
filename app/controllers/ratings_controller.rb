class RatingsController < ApplicationController

	layout 'application'

  def index
  	search
    @popular_items = Item.joins(:ratings).group(:name).count("ratings.id") 
  end

  def search
		@items = params[:search].present? ? Rating.search(params[:search]) : []
    # if Rating.search(params[:search]).count != params[:search].size
    #   redirect_to :root
    #   flash[:notice] = "One or more of your search terms in not currently in our database. Please log in to add these new item(s)."
    # end
  end

  def create
    @items = params[:search].present? ? Rating.search(params[:search]) : []
    if user_signed_in?
      if params[:search].present? 
          redirect_to :root
          flash[:alert] = "You must search for an item(s) before you can rate it."
      end
      @items.each do |item|
        # instantiate a new object
        @rating = Rating.create!(:item_id => item.id, :x_rating => item.x_rating, :y_rating => item.y_rating)
    # save the object
        if @rating.save
          # if save succeeds, redirect to the index action with a success method
          redirect_to :root
          flash[:notice] = "Congratulations. Your rating was successfully saved."
        else
          # if save fails, redisplay 
          redirect_to :root
          flash[:notice] = "Something went wrong. Please try again later." 
        end
      end     
    else
      # if user is not signed in
      render 'index'
      flash[:notice] = "Please log in to add your ratings."
    end
  end

  def update
  end

  def destroy
  end

end
