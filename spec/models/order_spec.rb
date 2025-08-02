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
        new_order = build(:order, user: user)
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
    context 'when product is not in order' do
      it 'creates new order_item with quantity 1' do
        expect {
          order.add_product(product)
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
          order.add_product(product)
        }.not_to change(order.order_items, :count)

        existing_order_item.reload
        expect(existing_order_item.quantity).to eq(3)
      end
    end
  end

  describe '#process (private method)' do
    let!(:order_item1) { create(:order_item, order: order, product: product, quantity: 1, total_price: 10.50) }
    let!(:order_item2) { create(:order_item, order: order, product: product, quantity: 2, total_price: 21.0) }



    it 'calls proceed on all order_items when transitioning to payed' do
      # We need to reload the items to get the actual instances that will be called
      order.reload
      order_items = order.order_items.to_a

      order_items.each do |item|
        expect(item).to receive(:proceed)
      end

      order.proceed!
      order.pay!
    end

    it 'creates new empty cart for user after payment' do
      initial_orders_count = user.orders.count

      order.proceed!
      order.pay!

      expect(user.orders.count).to eq(initial_orders_count + 1)
      new_cart = user.orders.where(status: :cart).last
      expect(new_cart.total_price).to eq(0.0)
      expect(new_cart.discount).to eq(0.0)
    end
  end
end
