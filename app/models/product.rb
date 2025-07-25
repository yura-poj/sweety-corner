class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_products

  validates :name, :discount, :price, :available_quantity, presence: true

end
