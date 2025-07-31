class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :total_price, presence: true

  aasm(:status, whiny_transitions: false) do
    state :cart, initial: true
    state :waiting_for_payment
    state :payed
    state :collecting
    state :delivering
    state :delivered
    state :finished
    state :canceled

    event :cancel do
      transitions to: :canceled
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
      transitions from: :delivering, to: :delivered
    end

    event :finish do
      transitions from: :delivered, to: :finished
    end
  end
end
