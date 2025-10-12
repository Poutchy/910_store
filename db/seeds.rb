# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

# Seed Users
users = [
  { email_address: "alice@example.com", password: "password" },
  { email_address: "bob@example.com", password: "password" },
  { email_address: "charlie@example.com", password: "password" },
  { email_address: "diana@example.com", password: "password" },
  { email_address: "edward@example.com", password: "password" }
]

users.each do |user_attrs|
  User.find_or_create_by!(email_address: user_attrs[:email_address]) do |user|
    user.password = user_attrs[:password]
  end
end

puts "Seeded #{User.count} users."

# Seed Products (10 sport clothes products)
products = [
  { name: "Running Shoes", inventory_count: 50 },
  { name: "Soccer Jersey", inventory_count: 30 },
  { name: "Basketball Shorts", inventory_count: 40 },
  { name: "Yoga Pants", inventory_count: 60 },
  { name: "Baseball Cap", inventory_count: 70 },
  { name: "Tennis Racket", inventory_count: 15 },
  { name: "Swimming Goggles", inventory_count: 25 },
  { name: "Fitness Tracker", inventory_count: 20 },
  { name: "Hoodie", inventory_count: 35 },
  { name: "Gym Bag", inventory_count: 45 }
]

products.each do |product_attrs|
  Product.find_or_create_by!(name: product_attrs[:name]) do |product|
    product.inventory_count = product_attrs[:inventory_count]
  end
end

puts "Seeded #{Product.count} products."

# Seed Subscribers (2 users subscribed to products)
# Let's subscribe Alice to Running Shoes and Bob to Basketball Shorts
alice = User.find_by(email_address: "alice@example.com")
bob = User.find_by(email_address: "bob@example.com")

running_shoes = Product.find_by(name: "Running Shoes")
basketball_shorts = Product.find_by(name: "Basketball Shorts")

Subscriber.find_or_create_by!(email: alice.email_address, product_id: running_shoes.id)
Subscriber.find_or_create_by!(email: bob.email_address, product_id: basketball_shorts.id)

puts "Seeded subscribers."
