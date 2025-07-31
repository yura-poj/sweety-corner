# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
[ "Candy", "Chocolate", "Snacks", "Drinks" ].each do |category_title|
  Category.find_or_create_by!(title: category_title)
end

Category.limit(10).each do |category|
  100.times do
    Product.find_or_create_by!(
      title: Faker::Commerce.product_name,
      description: Faker::Commerce.product_name,
      price: Faker::Commerce.price,
      available_quantity: Faker::Number.number(digits: 2),
      discount: Faker::Number.number(digits: 2),
      category: category
    )
  end
end
