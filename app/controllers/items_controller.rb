class ItemsController < ApplicationController
  def index
    @items = Item.search(params[:search])
    # @items = Item.all
    #
    # if params[:search]
    #   @items = Item.search(params[:search]).order("created_at DESC")
    # else
    #   @items = Item.all.order('created_at DESC')
    # end
  end

  def show
    @item = Item.find(params[:id])
  end
end
