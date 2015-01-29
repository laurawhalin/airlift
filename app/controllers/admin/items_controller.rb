module Admin
  class ItemsController < AdminController
    include AdminItemsHelper
    def index
      @items = Item.all
    end

    def new
      @item = Item.new
      set_all_categories
    end

    def create
      if category_list_nil?
        flash[:errors] = "You must select at least one category when creating a new item! Duh!"
        redirect_to new_admin_item_path
      else
        set_category_tag
        @item = Item.create(item_params)
        found_category_tags
        redirect_to admin_items_path
      end
    end

    def edit
      find_item
      set_all_categories
    end

    def update
      if category_list_nil?
        flash[:errors] = "Please reassign your item to at least one category "
        redirect_to new_admin_item_path
      else
        set_category_tag
        find_item
        @item.update(item_params)
        found_category_tags
        redirect_to admin_items_path
      end
    end
  end
end
