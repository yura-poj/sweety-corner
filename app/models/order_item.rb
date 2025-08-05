class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, :total_price, presence: true

  def add
    increment!(:quantity)
  end

  def remove
    if quantity <= 1
      destroy!
    else
      decrement!(:quantity)
    end
  end
end
