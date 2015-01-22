class OrdersController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    authorize! :read, @user
  end
end
