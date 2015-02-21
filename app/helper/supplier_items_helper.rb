module SupplierItemsHelper
  def add_categories_to_item(categories, item)
    categories.each do |cat_name|
      item.categories << Category.find_or_create_by(name: cat_name)
    end
  end

  def get_all_categories
    @categories = Category.all.uniq
  end

  def category_list_nil?
    params[:category_list] == nil
  end
end
