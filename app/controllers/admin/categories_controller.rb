module Admin
  class CategoriesController < AdminController
    def index
      @categories = Category.all
    end

    def new
      @category = Category.new
    end
  end
end
