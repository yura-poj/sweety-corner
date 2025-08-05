require 'rails_helper'

RSpec.describe Order::ProductDestroyer do
  let(:user) { create(:user) }
  let(:product) { create(:product, price: 10.50) }
  let(:order) { create(:order, user: user) }
  let(:order_item) { create(:order_item, quantity: 3, total_price: 21.0, order: order, product: product) }


  subject(:call_service) { described_class.new(order).call(product) }


  describe '.call' do
    it 'destroys the order_item' do
      order_item_id = order_item.id

      expect {
        call_service
      }.to change(OrderItem, :count).by(-1)

      expect { OrderItem.find(order_item_id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
