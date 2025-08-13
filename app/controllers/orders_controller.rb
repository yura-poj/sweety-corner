class OrdersController < ApplicationController
  include ActionPolicy::Behaviour

  before_action :authenticate_user!
  before_action :authorize!

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def cart
    @cart = current_user.cart
  end

  def destroy_cart
    @cart = current_user.cart.destroy!
    redirect_to categories_path, notice: "Cart cleared!"
  end
end
