class ProductAdder
  def initialize(order)
    @order = order
  end

  def call(product)
    @product = product

    add_product
  end

  private

  def add_product
    @position = @order.order_items.where(product: product).first
    if @position
      @position.add
    else
      @order.order_items.create(product: product, quantity: 1, total_price: product.price)
    end
  end
end
