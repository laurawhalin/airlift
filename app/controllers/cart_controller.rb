class CartController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item)
    session[:cart] = @cart.data
    flash[:notice] = "You have
     #{pluralize(@cart.count_of(item), item.title)} in your cart."
    redirect_to :back
  end
end
