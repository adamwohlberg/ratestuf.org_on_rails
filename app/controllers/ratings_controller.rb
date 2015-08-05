class RatingsController < ApplicationController

	layout 'application'

  def index
  	@users = User.all
  	@items = Item.all
  end
end
