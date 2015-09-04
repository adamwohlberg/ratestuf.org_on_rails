class RatingsController < ApplicationController
  def create
    @items = params[:search].present? ? Item.search(params[:search]) : []
    if @items.empty?
      redirect_to :root
      flash[:alert] = 'You must search for an item(s) before you can rate it.'
    elsif !user_signed_in?
      redirect_to :root
      flash[:alert] = 'You must log in before you can rate an item(s).'
    else
      # @items.each do |item|
      @rating = Rating.create!(item_id: item.id, x_rating: item.x_rating, y_rating: item.y_rating)
      if @rating.save
        redirect_to :root
        flash[:notice] = 'Congratulations. Your rating was successfully saved.'
      else
        redirect_to :root
        flash[:alert] = 'Something went wrong. Please try again later.'
      end
    end
    # end
    # else
    #   render 'index'
    #   flash[:notice] = "Please log in to add your ratings."
    # end
  end
end
