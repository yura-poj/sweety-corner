class ProductsController < ApplicationController
  include ActionPolicy::Behaviour
  before_action :set_product, only: [ :show, :edit, :update, :destroy, :add_to_cart,
                                     :remove_from_cart, :add_to_cart, :destroy_from_cart ]

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  before_action :authorize!

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

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      redirect_to edit_product_path(@product)
    end
  end

  def destroy
    if @product.destroy
      redirect_back(fallback_location: root_path, notice: "Product was successfully destroyed.")
    else
      redirect_back(fallback_location: root_path, notice: "Product was not destroyed.")
    end
  end

  def add_to_cart
    result = Order::ProductAdder.new(current_user.cart).call(@product)
    if result.success?
      flash[:notice] = "Product was added to cart!"
    else
      flash[:alert] = "Product was not added to cart!"
    end
    redirect_back(fallback_location: root_path)
  end

  def remove_from_cart
    result = Order::ProductRemover.new(current_user.cart).call(@product)
    if result.success?
      flash[:notice] = "Product was removed from cart!"
    else
      flash[:alert] = "Product was not removed from cart!"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy_from_cart
    result = Order::ProductDestroyer.new(current_user.cart).call(@product)
    if result.success?
      flash[:notice] = "Product was deleted from cart!"
    else
      flash[:alert] = "Product was not deleted from cart!"
    end
    redirect_back(fallback_location: root_path)
  end

  def product_params
    params.require(:product).permit(:title, :category_id, :price, :discount, :available_quantity, :description, :preview)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
