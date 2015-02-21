class Suppliers::OrdersController < SuppliersController
  def index
    @orders = { ordered: Order.ordered,
                paid: Order.paid,
                completed: Order.completed,
                cancelled: Order.cancelled
              }
    @all_orders = Order.all
  end

  def show
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
