class SuppliersController < ApplicationController

  def show
    @supplier = Supplier.where(slug: params[:slug]).includes(:items).take
		@user = User.new
	end

	def update
			@supplier = Supplier.find_by(slug: params[:slug])
	  	if @supplier.update(supplier_params) || @user.update(supplier_admin_params)
				flash[:success] = "Supplier successfully updated."
				redirect_to supplier_path(@supplier.slug)
			else
				flash[:error] = "Supplier could not be updated."
				redirect_to :back
			end
	end

	private

	def supplier_params
		params.require(:supplier).permit(:name,
																		 :description,
																		 :user )
	end

  def supplier_authorization
    redirect_to not_found_path if !current_user || current_user.supplier_slug(current_user.id) != params[:slug]
  end
end
