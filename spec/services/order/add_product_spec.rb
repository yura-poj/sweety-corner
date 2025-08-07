require 'rails_helper'

RSpec.describe Order::ProductAdder do
  let(:user) { create(:user) }
  let(:product) { create(:product, price: 10.50) }
  let(:order) { create(:order, user: user) }

  subject(:call_service) { described_class.new(order).call(product) }


  describe '.call' do
    context 'when product is not in order' do
      it 'creates new order_item with quantity 1' do
        expect {
          call_service
        }.to change(order.order_items, :count).by(1)

        order_item = order.order_items.last
        expect(order_item.product).to eq(product)
        expect(order_item.quantity).to eq(1)
        expect(order_item.total_price).to eq(product.price)
      end
    end

    context 'when product is already in order' do
      let!(:existing_order_item) do
        create(:order_item, order: order, product: product, quantity: 2, total_price: 21.0)
      end

      it 'increases quantity of existing order_item' do
        expect {
          call_service
        }.not_to change(order.order_items, :count)

        existing_order_item.reload
        expect(existing_order_item.quantity).to eq(3)
      end
    end
  end
end
