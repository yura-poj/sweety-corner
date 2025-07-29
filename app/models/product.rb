class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_items

  validates :title, :discount, :price, :available_quantity, presence: true
end
