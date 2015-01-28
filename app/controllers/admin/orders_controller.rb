module Admin
  class OrdersController < ApplicationController
    def index
      @orders = { ordered: Order.ordered,
                  paid: Order.paid,
                  completed: Order.completed,
                  cancelled: Order.cancelled
                }
    end

    def show
      @order = Order.find(params[:id])
      @user = User.find(@order.user_id)
    end

    def update
      @order = Order.find(params[:id])
      @order.status = "cancelled"
      redirect_to :back
    end

  end
end
