class Order < ApplicationRecord
  include AASM
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :total_price, :discount, presence: true
  validate :must_be_one_cart


  enum :status, [
    :cart, :waiting_for_payment, :payed, :collecting, :delivering, :completed,
    :received, :canceled ]

  aasm(:status, whiny_transitions: false, enum: true) do
    state :cart, initial: true
    state :waiting_for_payment
    state :payed, after_enter: :process
    state :collecting
    state :delivering
    state :completed
    state :received
    state :canceled

    event :cancel do
      transitions to: :canceled
    end

    event :cancel_payment do
      transitions to: :cart
    end

    event :proceed do
      transitions from: :cart, to: :waiting_for_payment
    end

    event :pay do
      transitions from: :waiting_for_payment, to: :payed
    end

    event :wait_seller do
      transitions from: :payed, to: :collecting
    end

    event :collect do
      transitions from: :collecting, to: :delivering
    end

    event :deliver do
      transitions from: :delivering, to: :completed
    end

    event :receive do
      transitions from: :completed, to: :received
    end
  end

  def add_product(product)
    position = order_items.where(product: product).first
    if position
      position.add
    else
      order_items.create(product: product, quantity: 1, total_price: product.price)
    end
  end

  private

  def process
    order_items.each do |order_item|
      order_item.proceed
    end

    user.orders.create!(total_price: 0, status: :cart, discount: 0)
  end

  def must_be_one_cart
    if user.orders.where(status: :cart).exists?
      errors.add(:base, "User already have an active cart.")
      throw(:abort)
    end
  end
end
