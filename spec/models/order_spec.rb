require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { create(:user) }
  let(:product) { create(:product, price: 10.50) }
  let(:order) { create(:order, user: user) }

  describe 'associations' do
    it { should belong_to :user }
    it { should have_many(:order_items).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:total_price) }

    context 'cart limit validation' do
      it 'allows creating first cart for user' do
        new_order = build(:order, user: user, status: :cart)
        expect(new_order).to be_valid
      end

      it 'prevents creating second cart for user' do
        create(:order, user: user, status: :cart)
        new_order = build(:order, user: user, status: :cart)
        expect(new_order.save).to be false
        expect(new_order.errors[:base]).to include('User already have an active cart.')
      end

      it 'allows creating cart if existing order is not cart status' do
        create(:order, :payed, user: user)
        new_order = build(:order, user: user, status: :cart)
        expect(new_order).to be_valid
      end
    end
  end

  describe '#add_product' do
  end

  describe '#pay!' do
    let!(:order_item1) { create(:order_item, order: order, product: product, quantity: 1, total_price: 10.50) }
    let!(:order_item2) { create(:order_item, order: order, product: product, quantity: 2, total_price: 21.0) }

    it 'creates new empty cart for user after payment' do
      initial_orders_count = user.orders.count

      order.apply!
      order.pay!

      expect(order.payed?).to be true
    end
  end
end
