class ItemsController < ApplicationController
  include ItemsSearchable
  layout 'application'

  def index
    flash.now[:alert] = search(params[:search])
    flash[:notice] = session[:message] if session[:message].present?
    session[:message] = nil
  end

end
