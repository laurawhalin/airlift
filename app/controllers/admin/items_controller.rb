module Admin
  class ItemsController < AdminController
    def index
      @items = Item.all
    end

    def new
      @item = Item.new
      @categories = Category.all
    end

    def create
      item = Item.create(item_params)
      string_category_tags = params[:category_list][:categories].uniq
      found_tags = string_category_tags.collect{|name| Category.find_or_create_by(name: name)}
      item.categories = found_tags
      redirect_to admin_items_path
    end

    def edit
      @item = Item.find(params[:id])
      @categories = Category.all
    end

    def update
      @item = Item.find(params[:id])
      @item.image = nil
      @item.update(item_params)
      redirect_to admin_items_path
    end
  end
end
