module Admin
  class ItemsController < AdminController
    def index
      @items = Item.all
    end

    def new
      @item = Item.new
    end

    def create
      Item.create(item_params)
      redirect_to admin_items_path
    end

    def edit
      @item = Item.find(params[:id])
    end

    def update
      @item = Item.find(params[:id])
      @item.update(item_params)
      redirect_to admin_items_path
    end
  end
  # private
  # why you no work here??? only works in Admin Controller
  # def item_params
  #   params.require(:item).permit(:title, :description, :price)
  # end
end
