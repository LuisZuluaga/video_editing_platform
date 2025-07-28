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
# 
puts "Seeding database..."

video_types = [
  { name: "Highlight Reel", format: "MP4 (Horizontal)", price: 150.00 },
  { name: "Full Documentary Edit", format: "MOV (Horizontal)", price: 300.00 },
  { name: "Teaser", format: "MP4 (Vertical)", price: 100.00 },
  { name: "Social Media Clip", format: "MP4 (Square)", price: 80.00 },
  { name: "Behind the Scenes", format: "MOV (Vertical)", price: 120.00 }
]

video_types.each do |vt|
  VideoType.find_or_create_by!(name: vt[:name], format: vt[:format]) do |video_type|
    video_type.price = vt[:price]
  end
end

clients = [
  { name: "Client A", email: "a@test.com" },
  { name: "Client B", email: "b@test.com" } ]

clients.each do |client_data|
  Client.find_or_create_by!(email: client_data[:email]) do |client|
    client.name = client_data[:name]
  end
end

ProjectManager.find_or_create_by!(email: "project@test.com") do |pm|
  pm.name = "Project Manager"
end

puts "Database seeded successfully!"

