# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Attendance.destroy_all
Event.destroy_all
User.destroy_all

User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "user9@yopmail.com", password: "motdepasse", description: "que du blabla", is_admin: true)

9.times do |i|
   User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "user#{i}@yopmail.com", password: "motdepasse", description: "que du blabla")
 end
puts "Users created"


15.times do
  Event.create!(duration: rand(1..200)*5, start_date: Time.now + rand(3600..360000), title: Faker::Book.title, description: "Encore un evenement qui casse des culs par rangées de 12", price: rand(1..1000), location: Faker::Nation.capital_city, administrator_id: User.all.sample.id, validated: true)
end
puts "Events created"


Event.all.each do |event|
  i = rand(1..9)
  i.times do
    users = User.all.reject{|u| event.administrator == u}.reject{|u| event.users.include?(u)}
    Attendance.create!(user_id: users.sample.id, event_id: Event.all.sample.id, stripe_customer_id: Faker::Code.ean)
  end
end
puts "Attendances created"
