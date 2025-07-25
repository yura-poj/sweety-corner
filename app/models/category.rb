class Category < ApplicationRecord
  has_many :products, dependent: :nullify

  validates :title, presence: true, uniqueness: true
end
