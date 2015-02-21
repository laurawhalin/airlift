class ItemsController < ApplicationController
  def index
    @items = Item.search(params[:search])
		@suppliers = Supplier.all
    @categories = Category.all
  end

  def show
    @item = Item.find(params[:id])
  end

	private

	def item_params
    params.require(:item).permit(:title,
                                 :description,
                                 :price,
                                 :image,
                                 :retired,
																:supplier_id)
	end
end
