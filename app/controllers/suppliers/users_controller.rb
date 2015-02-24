class Suppliers::UsersController < SuppliersController

	def update
		@user =  User.find(params[:id])
		if @user.update(supplier_admin_params)
			flash[:success] = "User successfully updated"
			redirect_to :back
		else
			flash[:errors] = "User could not be updated"
			redirect_to :back
		end
	end

	private

	def supplier_admin_params
		params.require(:user).permit(:fullname,
																 :email,
																 :role) 
	end
end
