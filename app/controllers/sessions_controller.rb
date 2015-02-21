class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
		if user && user.authenticate(params[:session][:password])
    	session[:user_id] = user.id
    	flash[:success] = "You have successfully logged in"
    	if user.supplier? && user.has_company?(user.id)
     		redirect_to supplier_path(user.supplier_slug(user.id))
    	elsif user.supplier? && !user.has_company?(user.id)
      	flash[:errors] = "User account not connected to supplier account, please contact system admin"
      	redirect_to :back
			else
				redirect_to :back
			end
    else
    	flash[:errors] = "Invalid login"
      redirect_to :back
		end
  end

  def destroy
    flash[:success] = "Successful logout"
    session.clear
    redirect_to root_path
  end
end
