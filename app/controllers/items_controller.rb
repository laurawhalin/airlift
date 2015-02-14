class ItemsController < ApplicationController
  def index
    @items = Item.all
		@suppliers = Supplier.all
  end

  def show
    @item = Item.find(params[:id])
  end
end
