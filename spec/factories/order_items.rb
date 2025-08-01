FactoryBot.define do
  factory :order_item do
    quantity { 1 }
    total_price { 10.50 }
    status { :pending }
    association :order
    association :product

    trait :ordered do
      status { :ordered }
    end

    trait :collecting do
      status { :collecting }
    end

    trait :delivered do
      status { :delivered }
    end

    trait :with_multiple_quantity do
      quantity { 3 }
      total_price { 31.50 }
    end
  end
end
