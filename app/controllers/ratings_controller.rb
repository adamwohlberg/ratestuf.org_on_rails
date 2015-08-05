class RatingsController < ApplicationController

	layout 'application'

  def index
  	@user = User.first
  end
end
