class CategoriesController < ApplicationController
  def show
    @spicy = @category.items.find(spicy) = Category.find(params[:id])
  end

  def index
    @categories = Category.all
  end

  private

  def categories_params
    params.require(:category).permit(:name, :description)
  end
end
