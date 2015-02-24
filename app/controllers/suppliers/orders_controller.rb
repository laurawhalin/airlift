class Suppliers::OrdersController < SuppliersController
  def index
    @orders = Order.get_supplier_orders(params)
  end

  def show
    @order = Order.get_order(current_user, params[:id])
    @user = Order.get_user(@order)
    @shipping_address = Order.get_shipping_address(@user)
  end

  def update
    order = Order.get_order(current_user, params[:id])
    order.change_status(order, params[:commit])
    redirect_to supplier_orders_path
  end
end
