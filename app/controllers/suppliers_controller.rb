class SuppliersController < ApplicationController
  def show
    @supplier = Supplier.where(slug: params[:slug]).includes(:items).take
	end

	def update
			@supplier = Supplier.find_by(slug: params[:slug])
	  	@supplier.update(supplier_params)
			flash[:success] = "Supplier successfully updated."
			redirect_to supplier_path(@supplier.slug)
	end

	private

	def supplier_params
		params.require(:supplier).permit(:name,
																		 :description)
	end
end
