class ProductsController < ApplicationController
  def index
    @pagy, @products = pagy(Product.all)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      redirect_to new_product_path(@product)
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product
    else
      redirect_to edit_product_path(@product)
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_back(fallback_location: root_path, notice: "Product was successfully destroyed.")
    else
      redirect_back(fallback_location: root_path, notice: "Product was not destroyed.")
    end
  end

  def add_to_cart
    @product = Product.find(params[:id])
    ProductAdder.new(current_user.cart).call(product: @product)
  end

  def remove_from_cart
    @product = Product.find(params[:id])
    ProductRemover.new(current_user.cart).call(product: @product)
  end

  def destroy_from_cart
    @product = Product.find(params[:id])

  end

  def product_params
    params.require(:product).permit(:title, :category_id, :price, :discount, :available_quantity, :description)
  end
end
