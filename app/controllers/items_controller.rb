class ItemsController < ApplicationController
  include ItemsSearchable
  layout 'application'

  def index
    flash.now[:alert] = search(params[:search])
    flash[:notice] = session[:message] if session[:message].present?
    session[:message] = nil

    # @items = Item.all
    # respond_to do |format|
    # 	format.html
    # 	format.js
    # 	format.json { render :json => @items.to_json(:include => :ratings) }
    # end

  end

end
