if Rails.env.production?
  puts "Skipping seeds in production environment"
  exit
end

[ "Candy", "Chocolate", "Snacks", "Drinks" ].each do |category_title|
  Category.find_or_create_by!(title: category_title)
end

# Path to the candy image
candy_image_path = Rails.root.join('storage', 'candy.jpeg')

Category.limit(10).each do |category|
  100.times do
    product = Product.find_or_create_by!(
      title: Faker::Commerce.product_name,
      description: Faker::Commerce.product_name,
      price: Faker::Commerce.price,
      available_quantity: Faker::Number.number(digits: 2),
      discount: Faker::Number.number(digits: 2),
      category: category
    )

    # Attach preview image if it exists and product doesn't have one
    if File.exist?(candy_image_path) && !product.preview.attached?
      product.preview.attach(
        io: File.open(candy_image_path),
        filename: 'candy.jpeg',
        content_type: 'image/jpeg'
      )
      puts "Attached preview to product: #{product.title}"
    end
  end
end
