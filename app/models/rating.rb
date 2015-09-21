class Rating < ActiveRecord::Base
  ## Associations ##
  belongs_to :item
  belongs_to :user

  ## Scope ##
  scope :item_ratings, -> (item_names) { eager_load(:item).where('items.id IN (?)', item_names).group(:item_id).pluck('item_id, AVG(x_rating) as AVG_X_RATING, AVG(y_rating) as AVG_Y_RATING, COUNT(item_id) as RATE_COUNT, items.name') }
  scope :fetch_rating, -> (user_id, item) { where(user_id: user_id, item_id: item['id']) }
  scope :last_rating_of_user, -> (user_id, item) { fetch_rating(user_id, item).last }

  ## Class Methods ##
  def self.generate_format(ratings)
    rate_format = []
    ratings.each do |rating|
      h = {}
      h[:id] = rating[0]
      h[:x_rating] = rating[1].to_f
      h[:y_rating] = rating[2].to_f
      h[:count] = rating[3]
      h[:name] = rating[4]
      rate_format << h
    end
    rate_format
  end
end
