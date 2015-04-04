class OrdersController < ApplicationController
  def index
    authorize! :read, current_user.id
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
  end

  def create
    @order = Order.create(
                          status: "ordered",
                          total: @cart.total * 100,
                          user_id: current_user.id
                          )
    items = Item.find(@cart.data.keys)
    @line_items = items.map do |item|
      OrdersItem.create(
                        order_id: @order.id,
                        item_id: item.id,
                        quantity: @cart.data[item.id.to_s],
                        subtotal: item.price * @cart.data[item.id.to_s]
                        )
    end
    session[:cart] = nil
    redirect_to user_order_path(current_user, @order)
  end
end
