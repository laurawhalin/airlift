class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      if user.supplier?
        redirect_to supplier_path(user.supplier_slug(user.id))
      else
        redirect_to :back
      end
    else
      flash[:errors] = "Invalid login"
      render :new
    end
  end

  def destroy
    flash[:success] = "Successful logout"
    session.clear
    redirect_to root_path
  end
end
