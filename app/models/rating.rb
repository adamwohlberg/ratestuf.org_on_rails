class Rating < ActiveRecord::Base
  belongs_to :item
  belongs_to :user

  def already_rated?(item)
    true if Rating.where(user_id: current_user.id, item_id: item['id']).exists?
  end

end
