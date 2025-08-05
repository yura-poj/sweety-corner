class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, :total_price, presence: true
  validates :product_id, uniqueness: { scope: :order_id }

  def add
    increment!(:quantity)
  end

  def remove
    decrement!(:quantity)
  end
end
