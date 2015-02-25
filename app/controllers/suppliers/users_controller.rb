class Suppliers::UsersController < SuppliersController

	def update
		@user =  User.find(params[:id])
		role = params[:user][:role]
		@supplier_admin = SupplierAdmin.find_by(user_id: @user.id)
		if @user.update(supplier_admin_params) && role == "supplier"
			flash[:success] = "User successfully updated"
			redirect_to supplier_path(@user.supplier_slug(@user.id))
		elsif role == "default"
			@supplier_admin.delete
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
