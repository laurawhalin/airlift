class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @listing = @category.items.all
  end

  helper_method :show

  def index
    @categories = Category.all
  end

  private

  def categories_params
    params.require(:category).permit(:name, :description)
  end
end
