module AdminItemsHelper
  def update_category_tag
    string_category_tags = params[:category_list][:categories].uniq
    @found_tags = string_category_tags.map do |name|
      Category.find_or_create_by(name: name)
    end
  end  
end
