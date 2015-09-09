class RatingsController < ApplicationController

  def create
    if @items.nil?
     flash[:alert] = 'You must search for an item(s) before you can rate it.'
    else
      @items = params[:items]
      @items.each do |item|
        @rating = Rating.create!(item_id: item.id, x_rating: item.x_rating, y_rating: item.y_rating)
      byebug
      end
    end
  end  



    # if @items.nil?
    #  render 'index'
    #  flash[:alert] = 'You must search for an item(s) before you can rate it.'
    # else
    # @items.each do |item|
    #   @rating = Rating.create!(user_id: @current_user.id, item_id: item.id, x_rating: item.x_rating, y_rating: item.y_rating)
    #   @rating.save
    #     flash[:notice] = 'Congratulations. Your rating was successfully saved.'
    #   else
    #     flash[:alert] = 'Something went wrong. Please try again later.'
    #   end
    # end
    # end 
  # end
end
