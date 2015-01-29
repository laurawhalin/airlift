module AdminItemsHelper
  def set_category_tag
    string_category_tags = params[:category_list][:categories].uniq
    @found_tags = string_category_tags.map do |name|
      Category.find_or_create_by(name: name)
    end
  end

  def set_all_categories
    @categories = Category.all
  end

  def category_list_nil?
    params[:category_list] == nil
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def found_category_tags
    @item.categories = @found_tags
  end
end
