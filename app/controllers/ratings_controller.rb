class RatingsController < ApplicationController
  def create
    # user = current_user
    # @items = params[:search].present? ? Item.search(params[:search]) : []
    # byebug
    # if @items.empty?
    #   redirect_to :root
    #   flash[:alert] = 'You must search for an item(s) before you can rate it.'
    # elsif !user_signed_in?
    #   redirect_to :root
    #   flash[:alert] = 'You must log in before you can rate an item(s).'
    # else
    #   @items.each do |item|
    #     # if the user has already rated this item, then update the rating
    #     @rating = Rating.create!(user_id: current_user.id, item_id: item.id, x_rating: item.x_rating, y_rating: item.y_rating)
    #     if @rating.save
    #       redirect_to :root
    #       flash[:notice] = 'Congratulations. Your rating was successfully saved.'
    #     else
    #       redirect_to :root
    #       flash[:alert] = 'Something went wrong. Please try again later.'
    #     end
    #   end
    # end
  end
end
