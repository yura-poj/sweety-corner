class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items, dependent: :destroy

  validates :title, :discount, :price, :available_quantity, presence: true

  has_one_attached :preview
end
