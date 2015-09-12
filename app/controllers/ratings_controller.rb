class RatingsController < ApplicationController

  def create
    @items = params[:items]
    if @items.present?
      @items.each do |item|
        #TODO add item already rated by this user then update instead of adding a new rating
        if already_rated_n_times?(item, 2)
          @last_rating = Rating.where(user_id: current_user.id, item_id: item['id']).last
          @rating = @last_rating.update_attributes(user_id: current_user.id, item_id: item['id'], x_rating: item['x_rating'], y_rating: item['y_rating'])
        else
          @rating = Rating.create!(user_id: current_user.id, item_id: item['id'], x_rating: item['x_rating'], y_rating: item['y_rating'])
        end
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

  private 

  def already_rated_n_times?(item, number)
    true if Rating.where(user_id: current_user.id, item_id: item['id']).count > number
  end

end
