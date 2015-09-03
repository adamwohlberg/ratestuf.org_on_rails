class ItemsController < ApplicationController
  include ItemsSearchable
	layout 'application'

  def index
    flash.now[:alert] = search(params[:search])
  end

  def update
  end

  def destroy
  end


end
