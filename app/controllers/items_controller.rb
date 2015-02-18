class ItemsController < ApplicationController
  def index
    @items = Item.search(params[:search])
		@suppliers = Supplier.all
    @categories = Category.all
  end

  def show
    @item = Item.find(params[:id])
  end
end
