class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @listing = @category.items.all
  end
  helper_method :show

  def create
    category = Category.create(categories_params)
    redirect_to admin_categories_path
  end

  private

  def categories_params
    params.require(:category).permit(:name, :description)
  end

end
