class OrderItem < ApplicationRecord
  include AASM
  belongs_to :order
  belongs_to :product

  validates :quantity, :total_price, presence: true

  enum :status, [
    :pending, :ordered, :collecting, :delivering, :delivered,
    :received, :canceled ]

  aasm(:status, whiny_transitions: false, enum: true) do
    state :pending, initial: true
    state :ordered
    state :collecting
    state :delivering
    state :delivered
    state :received
    state :canceled

    event :cancel do
      transitions to: :canceled
    end

    event :proceed do
      transitions from: :pending, to: :ordered
    end

    event :wait_seller do
      transitions from: :ordered, to: :collecting
    end

    event :collect do
      transitions from: :collecting, to: :delivering
    end

    event :deliver do
      transitions from: :delivering, to: :delivered
    end

    event :receive do
      transitions from: :delivered, to: :received
    end
  end

  def add
    self.quantity += 1
    save!
  end

  def remove
    if quantity > 1
      self.quantity -= 1
      save!
    else
      destroy
    end
  end
end
