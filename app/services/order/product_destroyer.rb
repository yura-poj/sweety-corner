# frozen_string_literal: true

class Order::ProductDestroyer
  include Dry::Monads[:result]

  def initialize(order)
    @order = order
  end

  def call(product)
    @product = product
    destroy_order_item
  end

  private

  def destroy_order_item
    @order_item = @order.order_items.find_by(product: @product)
    return Failure(:not_found) unless @order_item

    if @order_item.destroy
      Success(:ok)
    else
      Failure(:destroy_error)
    end
  end
end
