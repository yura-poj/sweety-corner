class Order::ProductAdder
  include Dry::Monads[:result]

  def initialize(order)
    @order = order
  end

  def call(product)
    @product = product
    add_quantity_or_create_order_item
  end

  private

  def add_quantity_or_create_order_item
    @order_item = @order.order_items.find_by(product_id: @product)

    @order_item ? increment_quantity : create_order_item
  end

  def increment_quantity
    @order_item.add
    Success(:ok)
  end

  def create_order_item
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
