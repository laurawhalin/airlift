class SuppliersController < ApplicationController
  def show
    @supplier = Supplier.where(slug: params[:slug]).includes(:items).take
  end

  def index
  end

	def new
	end

  def item_params
    params.require(:item).permit(:title,
                                 :description,
                                 :price,
                                 :image,
                                 :retired)
  end
end
