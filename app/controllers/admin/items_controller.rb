module Admin
  class ItemsController < AdminController
    def index
      @items = Item.all
    end

    def new
      @item = Item.new
    end

    def create

    end
  end
end
