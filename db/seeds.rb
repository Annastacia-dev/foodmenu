# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts 'Clearing sample data ...'
restaurant = Restaurant.find_by(sample: true)
if restaurant
  users = User.where(restaurant_id: restaurant.id )
  users.destroy_all
  restaurant.destroy
end

puts 'Seeding database ...'

# Restaurant
puts 'Creating sample restaurant ...'
Restaurant.create!(
  name: 'Web Cafe',
  email: 'info@webcafe.africa',
  phone: '25476832439',
  sample: true,
  confirmed: true
)
puts 'Sample restaurant created successfully!'

# User
puts 'Creating sample user ...'
User.create!(
  first_name: 'Web',
  last_name: 'Cafe',
  email: 'info@webcafe.africa',
  role: 'admin',
  password: 'changeme',
  restaurant: Restaurant.find_by(sample: true)
)
puts 'User created successfully!'

restaurant = Restaurant.find_by(sample: true)

# Menu
puts 'Creating sample menu'
restaurant.menus.create!(
  name: 'Main Menu',
  description: 'Our main menu',
  restaurant: Restaurant.find_by(sample: true)
)
puts 'Sample menu created successfully!'


# Menu Category
puts 'Creating sample menu categories ...'
menu = Menu.find_by(name: 'Main Menu')
menu.menu_categories.create!(
  [
    { name: 'Starters', menu_id: menu.id },
    { name: 'Main Course', menu_id: menu.id },
    { name: 'Desserts', menu_id: menu.id },
    { name: 'Drinks', menu_id: menu.id }
  ]
)
puts 'Sample menu categories created successfully!'

# Menu Item
puts 'Creating sample starters ...'
menu_category = restaurant.menu_categories.find_by(name: 'Starters')
MenuItem.create!(
  [
    { name: 'Chicken Wings', description: 'Spicy chicken wings', price: 500, menu_category_id: menu_category.id },
    { name: 'Chicken Salad', description: 'Grilled chicken salad', price: 400, menu_category_id: menu_category.id },
    { name: 'Beef Samosa', description: 'Crispy beef samosa', price: 300, menu_category_id: menu_category.id }
  ]
)
puts 'Sample starters created successfully!'

puts 'Creating sample main course ...'
menu_category = restaurant.menu_categories.find_by(name: 'Main Course')
MenuItem.create!(
  [
    { name: 'Beef Burger', description: 'Beef burger with fries', price: 800, menu_category_id: menu_category.id },
    { name: 'Chicken Burger', description: 'Grilled chicken burger with fries', price: 700, menu_category_id: menu_category.id },
    { name: 'Fish and Chips', description: 'Fried fish and chips', price: 600, menu_category_id: menu_category.id }
  ]
)
puts 'Sample main course created successfully!'

puts 'Creating sample desserts ...'
menu_category = restaurant.menu_categories.find_by(name: 'Desserts')
MenuItem.create!(
  [
    { name: 'Chocolate Cake', description: 'Chocolate cake with ice cream', price: 300, menu_category_id: menu_category.id },
    { name: 'Fruit Salad', description: 'Fresh fruit salad', price: 200, menu_category_id: menu_category.id },
    { name: 'Ice Cream', description: 'Vanilla ice cream', price: 100, menu_category_id: menu_category.id }
  ]
)
puts 'Sample desserts created successfully!'

puts 'Creating sample drinks ...'
menu_category = restaurant.menu_categories.find_by(name: 'Drinks')
MenuItem.create!(
  [
    { name: 'Soda', description: 'Coca cola', price: 100, menu_category_id: menu_category.id },
    { name: 'Juice', description: 'Fresh fruit juice', price: 150, menu_category_id: menu_category.id },
    { name: 'Water', description: 'Bottled water', price: 50, menu_category_id: menu_category.id }
  ]
)
puts 'Sample drinks created successfully!'
puts 'Seeding database completed successfully!'