class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @pagy, @products = pagy(@category.products.all)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "Category created!"
    else
      redirect_to new_category_path, alert: "Category not created!"
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path, notice: "Category updated!"
    else
      redirect_to edit_category_path(@category), alert: "Category not updated!"
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to categories_path, notice: "Category deleted!"
  end

  def category_params
    params.require(:category).permit(:title)
  end
end
