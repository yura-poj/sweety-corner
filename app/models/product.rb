class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_products
end
