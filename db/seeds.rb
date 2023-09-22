# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

5.times do
  Merchant.create(
  name: Faker::Company.name
  )
end
  
  
20.times do
  Item.create(
  name: Faker::Commerce.product_name,
  description: Faker::Lorem.sentence,
  unit_price: Faker::Commerce.price(range: 1..100.0, as_string: false),
  merchant_id: Merchant.pluck(:id).sample,
  status: [0, 1].sample
  )
end

20.times do
  Discount.create(
  percent: Faker::Number.decimal(l_digits: 2),
  quantity_threshold: Faker::Number.between(from: 1, to: 20),
  merchant_id: Merchant.pluck(:id).sample
  )
end