require 'rails_helper'

RSpec.describe Order::ProductRemover do
  let(:user) { create(:user) }
  let(:product) { create(:product, price: 10.50) }
  let(:order) { create(:order, user: user) }
  let(:order_item) { create(:order_item, quantity: 3, total_price: 21.0, order: order, product: product) }


  subject(:call_service) { described_class.new(order).call(product) }


  describe '.call' do
    context 'when quantity is > 1' do
      it 'call remove on order item' do
        order_item
        
        allow(order.order_items).to receive(:find_by).with(product: product).and_return(order_item)
        expect(order_item).to receive(:remove)

        call_service
      end
    end

    context 'when quantity is <= 1' do
      it 'destroys the order_item' do
        order_item.update!(quantity: 1)
        order_item_id = order_item.id

        expect {
          call_service
        }.to change(OrderItem, :count).by(-1)

        expect { OrderItem.find(order_item_id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
