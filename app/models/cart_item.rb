class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :product_id, :quantity, presence: true
end
