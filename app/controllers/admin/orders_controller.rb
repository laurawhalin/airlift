module Admin
  class OrdersController < ApplicationController
    def index
      @orders = { ordered: Order.ordered,
                  paid: Order.paid,
                  completed: Order.completed,
                  cancelled: Order.cancelled
                }
    end
  end
end
