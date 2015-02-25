module SupplierItemsHelper
  def get_all_categories
    @categories = Category.all
  end

  def category_list_nil?
    params[:category_list] == nil
  end
end
