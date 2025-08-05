class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def cart
    @cart = current_user.cart
  end

  def destroy_cart
    @cart = current_user.cart.destroy!
    redirect_to categories_path, notice: "Cart cleared!"
  end
end
