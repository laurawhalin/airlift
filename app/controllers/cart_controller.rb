class CartController < ApplicationController
  before_action :supplier_authorization

  def index
    redirect_to :back
  end

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item)
    session[:cart] = @cart.data
    flash[:notice] = "You have
     #{pluralize(@cart.count_of(item), item.title)} in your cart."
    redirect_to :back
  end

  def update
    @cart = @cart.update_qty(params)
    redirect_to :back
  end

  def show
  end

  def destroy
    item = Item.find(params[:id])
    @cart.delete_item(item.id)
    redirect_to cart_path
  end

  private

  def supplier_authorization
    redirect_to not_found_path if current_user && current_user.supplier?
  end
end
