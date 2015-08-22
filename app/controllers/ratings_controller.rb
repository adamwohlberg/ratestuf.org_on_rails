class RatingsController < ApplicationController

	layout 'application'

  def index
  	search

  end

  def search
		@items = params[:search].present? ? Rating.search(params[:search]) : []
		# byebug

  end

end
