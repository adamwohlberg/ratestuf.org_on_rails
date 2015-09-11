class RatingsController < ApplicationController

  def create
    @items = params[:items]
    if !current_user
      render "items/index"
     flash[:alert] = 'You must log in to rate stuff.'     
    elsif @items.nil?
     render "items/index"
     flash[:alert] = 'You must search for an item(s) before you can rate it.'
    else    
      @items.each do |item|
        #TODO add if already rated then update instead of adding a new rating
        @rating = Rating.create!(item_id: item['id'], x_rating: item['x_rating'], y_rating: item['y_rating'])
      end
    end
    respond_to do |format|
      if @rating.save
        format.html { redirect_to @items, notice: 'Congratulations. Your rating(s) were successfully saved into the updated ratings appearing below:' }
        format.js   {}
        format.json { render :json => @items.to_json(:include => [:ratings])}
      else
        format.html { render 'items/index' }
        format.json { render json: @items.errors, status: :unprocessable_entity }
      end
    end
  end

end
