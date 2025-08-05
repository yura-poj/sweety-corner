FactoryBot.define do
  factory :product do
    sequence(:title) { |n| "Product #{n}" }
    description { "A great product description" }
    price { 10.50 }
    discount { 0.0 }
    available_quantity { 100 }
    association :category
  end
end
