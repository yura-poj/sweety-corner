class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, :total_price, presence: true
end
