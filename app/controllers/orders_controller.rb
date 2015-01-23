class OrdersController < ApplicationController
  def index
    user = User.find(params[:user_id])
    authorize! :read, user
    @past_orders = user.past_orders
  end
end
