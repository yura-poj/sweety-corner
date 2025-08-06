# frozen_string_literal: true

class Order::ProductDestroyer
  include Dry::Monads[:result]

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
    Failure(:not_found) unless @position

    if @position.destroy
      Success(:ok)
    else
      Failure(:destroy_error)
    end
  end
end
