class Suppliers::ItemsController < SuppliersController

  include SupplierItemsHelper
  def index
		@supplier = Supplier.where(slug: params[:slug]).includes(:items).take
		@item = Item.new
    if authorize! :read, @supplier
  		get_all_categories
    else
      redirect_to not_found_path
    end
  end

  def new
    @supplier = Supplier.find_by(slug: params[:slug])
	 	@item = @supplier.items.new
    get_all_categories
  end

  def create
		@supplier = Supplier.find_by(slug: params[:slug])
		@item = @supplier.items.new(supplier_item_params)
    if category_list_nil?
      flash[:errors] = "You must select at least one category when creating a new item! Duh!"
      redirect_to :back
		elsif authorize! :manage, @item
      @item.save
      @item.add_categories_to_item(params[:category_list][:categories])
			flash[:success] = "Item successfully saved"
      redirect_to supplier_items_path(@supplier.slug)
		else
			flash[:error] = "Item not saved"
      redirect_to :back
    end
  end

  def edit
    @supplier = Supplier.where(slug: params[:slug]).includes(:items).take
    @item = @supplier.items.where(id: params[:id]).take
    @categories = Category.all
  end

  def update
    @supplier = Supplier.where(slug: params[:slug]).includes(:items).take
    item = @supplier.items.where(id: params[:id]).take
    if category_list_nil?
      flash[:errors] = "Please reassign your item to at least one category "
      redirect_to :back
    else
      item.add_categories_to_item(params[:category_list][:categories])
      item.update(supplier_item_params)
      flash[:success] = "Item successfully updated"
      redirect_to supplier_items_path(@supplier.slug)
    end
  end

	private

	def supplier_item_params
		params.require(:item).permit(:title,
																 :description,
																 :price,
                                 :location,
																 :retired,
																 :supplier_id,
																 :quantity,
                                 :unit_size,
                                 :unit_weight,
                                 :shippable,
                                 :available,
                                 :image)
	end
end
