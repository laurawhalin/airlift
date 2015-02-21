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
end
