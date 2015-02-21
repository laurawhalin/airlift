class Suppliers::ItemsController < SuppliersController
  include SupplierItemsHelper
  def index
		 @supplier = Supplier.where(slug: params[:slug]).includes(:items).take
		 @item = Item.new
		 @categories = Category.all
  end

  def new
    @supplier = Supplier.find_by(slug: params[:slug])
	 	@item = Item.new
    @categories = Category.all
  end

  def create
		@supplier = Supplier.find_by(slug: params[:slug])
		item = Item.new(supplier_item_params)
		params[:category_list][:categories].each do |cat_name|
			item.categories << Category.find_or_create_by(name: cat_name)
		end
    if category_list_nil?
      flash[:errors] = "You must select at least one category when creating a new item! Duh!"
      redirect_to :back
		elsif item.save
			flash[:success] = "Item successfully saved"
      redirect_to supplier_items_path(@supplier.slug)
		else
			flash[:error] = "Item not saved"
			redirect_to new_supplier_item_path(@supplier.slug)
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

	  def category_list_nil?
    params[:category_list] == nil
  end

		private

		def supplier_item_params
			params.require(:item).permit(:title,
																	 :description,
																	 :price,
																	 :retired,
																	 :supplier_id,
																	 :quantity)
		end
end
