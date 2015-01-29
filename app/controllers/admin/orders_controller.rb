module Admin
  class OrdersController < ApplicationController
    include AdminOrdersHelper
    def index
      @orders = { ordered: Order.ordered,
                  paid: Order.paid,
                  completed: Order.completed,
                  cancelled: Order.cancelled
                }
      @all_orders = Order.all
    end

    def show
      @order = Order.find(params[:id])
      @user = User.find(@order.user_id)
    end

    def update
      change_status
    end
  end
end
