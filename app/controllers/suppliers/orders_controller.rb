class Suppliers::OrdersController < SuppliersController
  def index
    @orders = Order.get_supplier_orders_by_status(params)
  end

  def show
    @order = Order.get_order(params)
    @orders_items = Order.get_items(params)
    @user = Order.get_user(@order)
    @shipping_address = Order.get_shipping_address(@user)
  end

  def update
    order = Order.get_order(params)
    order.change_status(order, params[:commit])
    redirect_to supplier_orders_path
  end
end
