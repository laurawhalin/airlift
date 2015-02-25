class SuppliersController < ApplicationController
  def show
    @supplier = Supplier.where(slug: params[:slug]).includes(:items).take
    authorize! :read, @supplier
	end

	def update
			@supplier = Supplier.find_by(slug: params[:slug])
      authorize! :update, @supplier
	  	if @supplier.update(supplier_params)
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
																		 :description)
	end
end
