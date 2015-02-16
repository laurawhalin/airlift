class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @listing = @category.items.all
  end
end
