# frozen_string_literal: true

class Order::ProductRemover

  def initialize(order)
    @order = order
  end

  def call(product)
    @product = product
    remove_product
  end

  private

  def remove_product
    @position = @order.order_items.find_by(product: @product)
    return unless @position

    @position.quantity <= 1 ? @position.destroy! : @position.remove
  end
end
