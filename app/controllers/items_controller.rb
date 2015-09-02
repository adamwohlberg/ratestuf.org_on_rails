class ItemsController < ApplicationController
  include ItemsSearchable
	layout 'application'

  def index
    flash.now[:alert] = search(params[:search])
  end

  def create
    # @items = Item.search(params[:search])
    # @items.each do |item|
    #   next if Item.find_by_name(item.strip).exists?
    #   Item.create!(name: item.name)
    # end
  end

  def update
  end

  def destroy
  end


end
