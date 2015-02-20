class Suppliers::ItemsController < SuppliersController
  include SupplierItemsHelper
  def index
		 @supplier = Supplier.where(slug: params[:slug]).includes(:items).take
		 @item = Item.new
    set_all_categories
  end

  def new
	 	@item = Item.new
  end

  def create
    if category_list_nil?
      flash[:errors] = "You must select at least one category when creating a new item! Duh!"
      redirect_to new_supplier_path
    else
      create_category
      redirect_to suppliers_path
    end
  end

  def edit
    find_item
    set_all_categories
  end

  def update
    if category_list_nil?
      flash[:errors] = "Please reassign your item to at least one category "
      redirect_to suppliers_path
    else
      update_category
      redirect_to suppliers_path
    end
  end
end
