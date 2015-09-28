class RatingsController < ApplicationController
  
  def create
    session[:message] = nil
    flash[:message] = nil
    @items = params[:items]
    if @items.present?
      @item_ids = []
      @items.each do |item|
        if only_has_default_rating?(item)
          update_default_rating(item)
        elsif already_rated_n_times?(item, 0)
          update_rating(item)
        else
          create_rating(item)
        end
        @item_ids << item['id']
      end
    end
    @ratings = Rating.generate_format(Rating.item_ratings(@item_ids))
    respond_to do |format|
      format.json { render :json => @ratings.to_json }
    end
  end

  private

  def only_has_default_rating?(item)
    Item.where(name: item[:name]).first.ratings.count == 1 &&
    Item.where(name: item[:name]).first.ratings.first.default_rating == true
  end

  def already_rated_n_times?(item, number)
    Rating.fetch_rating(current_user.id, item).count > number
  end

  def update_default_rating(item)
    @default_rating = Rating.where(item_id: item['id']).first
    @default_rating.update_attributes(user_id: current_user.id, x_rating: item['x_rating'], y_rating: item['y_rating'], default_rating: false)
    flash[:notice] = 'Congratulations! Your rating(s) were saved.'
  end

  def create_rating(item)
    @rating = Rating.create!(user_id: current_user.id, item_id: item['id'], x_rating: item['x_rating'], y_rating: item['y_rating'], default_rating: false)
    flash[:notice] = 'Congratulations! Your rating(s) were saved.'
  end

  def update_rating(item) 
    @last_rating = Rating.last_rating_of_user(current_user.id, item)
    @last_rating.update_attributes(user_id: current_user.id, item_id: item['id'], x_rating: item['x_rating'], y_rating: item['y_rating'])
  end

end
