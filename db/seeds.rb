# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# create 3 users with faker gem Thuthikaran Easvaran
User::create!(email: "pedro@mail.com", password: 'password', password_confirmation: 'password', first_name: 'Pedro', last_name: 'Leal')
User::create!(email: "thuthi@mail.com", password: 'password', password_confirmation: 'password', first_name: 'Thuthikaran', last_name: 'Easvaran')
User::create!(email: "sahba@mail.com", password: 'password', password_confirmation: 'password', first_name: 'Sahba', last_name: 'Azhari')
User::create!(email: "sahba@mail.com", password: 'password', password_confirmation: 'password', first_name: 'Jeannine', last_name: 'Vernon')
