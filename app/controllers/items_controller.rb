class ItemsController < ApplicationController
  include ItemsSearchable
  layout 'application'

  def index
    flash.now[:alert] = search(params[:search])
    flash.now[:notice] = session[:message] if session[:message].present?

    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

end
