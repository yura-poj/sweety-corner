FactoryBot.define do
  factory :order_item do
    quantity { 1 }
    total_price { 10.50 }

    association :order
    association :product
  end
end
