require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:order_item) { create(:order_item, quantity: 2, total_price: 21.0) }

  describe 'associations' do
    it { should belong_to(:product) }
    it { should belong_to(:order) }
  end

  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :total_price }
  end

  describe '#add' do
    it 'increases quantity by 1 and saves' do
      initial_quantity = order_item.quantity
      order_item.add

      order_item.reload
      expect(order_item.quantity).to eq(initial_quantity + 1)
    end

    it 'persists the change to database' do
      initial_quantity = order_item.quantity
      order_item.add

      # Create a new instance to verify persistence
      reloaded_item = OrderItem.find(order_item.id)
      expect(reloaded_item.quantity).to eq(initial_quantity + 1)
    end
  end

  describe '#remove' do
    context 'when quantity is greater than 1' do
      it 'decreases quantity by 1 and saves' do
        order_item.update!(quantity: 3)
        initial_quantity = order_item.quantity

        order_item.remove

        order_item.reload
        expect(order_item.quantity).to eq(initial_quantity - 1)
      end
    end
  end
end
