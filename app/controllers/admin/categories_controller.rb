module Admin
  class CategoriesController < AdminController
    def index
      @categories = Category.all
    end

    def new
      @category = Category.new
    end

    def create
      category = Category.new(category_params)
      if category.save
        flash[:notice] = "New category successfully created!"
        redirect_to admin_categories_path
      else
        flash[:error] = "Unable to create category"
        redirect_to new_admin_category_path
      end
    end

    def edit
      @category = Category.find(params[:id])
    end

    def destroy
      category = Category.find(params[:id])
      category.destroy
      redirect_to admin_categories_path
    end

    private
    def category_params
      params.require(:category).permit(:name, :description)
    end
  end
end
