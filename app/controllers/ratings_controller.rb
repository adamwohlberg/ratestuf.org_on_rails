class RatingsController < ApplicationController

  def create
    @items = params[:items]
    @item_ids = []
    if @items.present?
      @items.each do |item|
        if already_rated_n_times?(item, 2)
          @last_rating = Rating.where(user_id: current_user.id, item_id: item['id']).last
          @rating = @last_rating.update_attributes(user_id: current_user.id, item_id: item['id'], x_rating: item['x_rating'], y_rating: item['y_rating'])
          session[:message] = 'Congratulations! Your rating(s) were updated.'
        else
          @rating = Rating.create!(user_id: current_user.id, item_id: item['id'], x_rating: item['x_rating'], y_rating: item['y_rating'])
        end
        @item_ids << item['id']
      end
      session[:message] ||= 'Congratulations! Your rating(s) were saved.'
    end 
    @items = Item.where(id: @item_ids)
    respond_to do |format|
      @result = custom_json(@items)
      format.json { render :json => @result.to_json } 
    end
  end

  private 

  def already_rated_n_times?(item, number)
    true if Rating.where(user_id: current_user.id, item_id: item['id']).count > number
  end

  def custom_json(items)

    json = {}
    avg_x_rating = 0
    avg_y_rating = 0
    cumulative_x_rating = 0.00
    cumulative_y_rating = 0.00

    items.each do |item|
      item.ratings.each do |rating|
        cumulative_x_rating += rating.x_rating.to_f
        cumulative_y_rating += rating.y_rating.to_f
      end
      avg_x_rating = (cumulative_x_rating / item.ratings.count).to_f
      avg_y_rating = (cumulative_y_rating / item.ratings.count).to_f
      json.merge!({ id: item.id, name: item.name, url: item.url, avg_x_rating: avg_x_rating, avg_y_rating: avg_y_rating })
    end
  end


end









