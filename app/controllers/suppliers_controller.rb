class SuppliersController < ApplicationController
  def show
    @supplier = Supplier.where(slug: params[:slug]).includes(:items).take
		@user = User.new
	end

	def update
			@supplier = Supplier.find_by(slug: params[:slug])
			@user = User.find_by(id: @user.id)
	  	if @supplier.update(supplier_params) || @user.update(supplier_admin_params)
				flash[:success] = "Supplier successfully updated."
				redirect_to supplier_path(@supplier.slug)
			else
				flash[:error] = "Supplier could not be updated."
				redirect_to :back
			end
	end

	private

	def supplier_admin_params
		params.require(:user).permit(:fullname,
																 :email,
																 :role)
	end

	def supplier_params
		params.require(:supplier).permit(:name,
																		 :description)
	end
end
