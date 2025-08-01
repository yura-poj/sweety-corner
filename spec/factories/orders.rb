FactoryBot.define do
  factory :order do
    total_price { 0.0 }
    discount { 0.0 }
    status { :cart }
    association :user

    trait :with_items do
      after(:create) do |order|
        create_list(:order_item, 2, order: order)
      end
    end

    trait :payed do
      status { :payed }
      total_price { 50.0 }
    end

    trait :delivered do
      status { :delivered }
      total_price { 50.0 }
    end
  end
end
