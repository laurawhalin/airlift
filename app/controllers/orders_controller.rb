class OrdersController < ApplicationController
  def index
    @user = User.find(params[:id])
    authorize! :read, @user
  end
end
