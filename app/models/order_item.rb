class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, :total_price, presence: true

  def add
    increment!(quantity)
  end

  def remove
    quantity.positive? ? decrement!(quantity) : destroy!
  end
end
