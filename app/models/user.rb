class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders, dependent: :destroy

  def cart
    @cart ||= orders.find_by(status: :cart) || create_cart
  end

  private

  def create_cart
    orders.create!(status: :cart, total_price: 0, discount: 0)
  end
end
