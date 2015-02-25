class Suppliers::OrdersController < SuppliersController

  def index
    @orders = Order.get_supplier_orders_by_status(params)
  end

  def show
    @order = Order.get_order_and_items(params[:id])
    @user = @order.get_user(@order)
    @shipping_address = @user.get_shipping_address(@user)
  end

  def update
    @order = Order.get_order_and_items(params[:id])
    @order.change_status(params[:commit])
    redirect_to supplier_orders_path
  end

end
