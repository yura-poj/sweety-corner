class Order < ApplicationRecord
  include AASM
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :total_price, :discount, presence: true
  validate :must_be_one_cart, on: :create


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

    event :apply do
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

  private

  def process
    user.orders.create!(total_price: 0, status: :cart, discount: 0)
  end

  def must_be_one_cart
    return if user.blank?

    if user.orders.where(status: :cart).exists?
      errors.add(:base, "User already have an active cart.")
    end
  end
end
