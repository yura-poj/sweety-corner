# frozen_string_literal: true

class Order::ProductRemover
  include Dry::Monads[:result]

  def initialize(order)
    @order = order
  end

  def call(product)
    @product = product
    find_and_process_order_item
  end

  private

  def find_and_process_order_item
    @order_item = @order.order_items.find_by(product: @product)
    return Failure(:not_found) unless @order_item

    @order_item.quantity <= 1 ? destroy_order_item : decrement_quantity
  end

  def decrement_quantity
    @order_item.remove
    Success(:ok)
  end

  def destroy_order_item
    if @order_item.destroy
      Success(:ok)
    else
      Failure(:cannot_destroy)
    end
  end
end
