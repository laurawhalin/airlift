module SupplierItemsHelper
  

  def get_all_categories
    @categories = Category.all.uniq
  end

  def category_list_nil?
    params[:category_list] == nil
  end
end
