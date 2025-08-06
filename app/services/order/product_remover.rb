# frozen_string_literal: true

class Order::ProductRemover
  include Dry::Monads[:result]

  def initialize(order)
    @order = order
  end

  def call(product)
    @product = product
    remove_or_delete_product
  end

  private

  def remove_or_delete_product
    @position = @order.order_items.find_by(product: @product)
    Failure(:not_found) unless @position

    @position.quantity <= 1 ? destroy_product : remove_product
  end

  def remove_product
    @position.remove
    Success(:ok)
  end

  def destroy_product
    if @position.destroy
      Success(:ok)
    else
      Failure(:cannot_destroy)
    end
  end
end
