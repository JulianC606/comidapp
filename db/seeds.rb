# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

useradmin = Rails.application.credentials.useradmin.presence || { 'email' => 'admin@example.com', 'password' => '123QWEqwe!' }
User.create!(email_address: useradmin['email'], password: useradmin['password'], admin: true, locale: :es) if User.count.zero?

food_provider = FoodProvider.create(name: 'Base', default: true)

Participant.create!(name: 'John Doe', barcode: '1', role: 'speaker', food_provider:)
