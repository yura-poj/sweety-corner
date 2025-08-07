class Order::ProductAdder
  include Dry::Monads[:result]

  def initialize(order)
    @order = order
  end

  def call(product)
    @product = product
    add_or_create_product
  end

  private

  def add_or_create_product
    @position = @order.order_items.find_by(product_id: @product)

    @position ? add_product : create_product
  end

  def add_product
    @position.add
    Success(:ok)
  end

  def create_product
    order = @order.order_items.create(
      product: @product,
      quantity: 1,
      total_price: @product.price
    )

    if order
      Success(:success)
    else
      Failure(:cannot_create_product)
    end
  end
end
