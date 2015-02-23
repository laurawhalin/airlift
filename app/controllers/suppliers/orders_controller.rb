class Suppliers::OrdersController < SuppliersController
  def index
    @orders = { ordered: Order.ordered,
                paid: Order.paid,
                completed: Order.completed,
                cancelled: Order.cancelled
              }
  end

  def show
    @order = Order.find(params[:id])
    @user = User.find(@order.addresses.where(address_type: "billing").first.user_id)
    @shipping_address = @user.addresses.where(address_type: "shipping").first
  end

  def update
    @order = Order.find(params[:id])
    case params[:commit]
    when "Cancel Order"
      @order.update(status: "cancelled")
    when "Mark as Shipped"
      @order.update(status: "completed")
    end
    redirect_to supplier_orders_path
  end
end
