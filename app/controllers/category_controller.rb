class CategoryController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_index_path, notice: "Category created!"
    else
      redirect_to category_path(create), alert: "Category not created!"
    end
  end

  def edit
  end

  def update
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to category_index_path, notice: "Category deleted!"
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
