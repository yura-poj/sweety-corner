class ProductsController < ApplicationController
  PRODUCTS_PER_PAGE = 20
  def index
    @products = Product.page(params[:page]).per(PRODUCTS_PER_PAGE)
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
