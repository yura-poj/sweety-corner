# frozen_string_literal: true

class Order::ProductDestroyer

  def initialize(order)
    @order = order
  end

  def call(product)
    @product = product
    destroy_product
  end

  private

  def destroy_product
    @position = @order.order_items.find_by(product: @product)
    @position.destroy!
  end
end
