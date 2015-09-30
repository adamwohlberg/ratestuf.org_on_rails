class RatingsController < ApplicationController
  
  def create
    session[:message] = nil
    @items = params['items']
    if @items.present?
      @item_ids = []
      @items.keys.each do |key|
        item = @items[key]
        if only_has_default_rating?(item)
          update_default_rating(item)
          flash.now[:notice] = 'Congratulations! Your rating(s) were saved.'
        elsif already_rated_n_times?(item, 0)
          update_rating(item)
          flash.now[:notice] = "You can only rate an item one (1) time. Future attempts will simply update your previous rating."
        else
          create_rating(item)
          flash.now[:notice] = 'Congratulations! Your rating(s) were saved.'
        end
        @item_ids << item['id']
      end
    end
    @ratings = Rating.generate_format(Rating.item_ratings(@item_ids))
    respond_to do |format|
      format.js {}
    end
  end

  private

  def only_has_default_rating?(item)
    item_ratings = Item.find_by(name: item[:name]).ratings
    item_ratings.count == 1 && item_ratings.first.default_rating
  end

  def already_rated_n_times?(item, number)
    Rating.fetch_rating(current_user.id, item).count > number
  end

  def update_default_rating(item)
    @default_rating = Rating.where(item_id: item['id']).first
    @default_rating.update_attributes(user_id: current_user.id, x_rating: item['x_rating'], y_rating: item['y_rating'], default_rating: false)
  end

  def create_rating(item)
    @rating = Rating.create!(user_id: current_user.id, item_id: item['id'], x_rating: item['x_rating'], y_rating: item['y_rating'], default_rating: false)
  end

  def update_rating(item) 
    @last_rating = Rating.last_rating_of_user(current_user.id, item)
    @last_rating.update_attributes(user_id: current_user.id, item_id: item['id'], x_rating: item['x_rating'], y_rating: item['y_rating'])
  end

end
