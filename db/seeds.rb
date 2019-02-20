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

def get_random_image(image_path_prefix)
  image_files = Dir.glob("#{image_path_prefix}*")
  image_files.sample.split(image_path_prefix)[1]
end

user = User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "user9@yopmail.com", password: "motdepasse", description: "que du blabla", is_admin: true)
user.avatar.attach(io: File.open("app/assets/images/users/sample/#{get_random_image("app/assets/images/users/sample/")}"), filename: get_random_image("app/assets/images/users/sample/"))

9.times do |i|
   user = User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "user#{i}@yopmail.com", password: "motdepasse", description: "que du blabla")
  user.avatar.attach(io: File.open("app/assets/images/users/sample/#{get_random_image('app/assets/images/users/sample/')}"), filename: get_random_image("app/assets/images/users/sample/"))
  end
puts "Users created"


15.times do
  event = Event.create!(duration: rand(1..200)*5, start_date: Time.now + rand(3600..360000), title: Faker::Book.title, description: "Encore un evenement qui casse des culs par rangées de 12", price: rand(1..1000), location: Faker::Nation.capital_city, administrator_id: User.all.sample.id, validated: true)
  event.event_image.attach(io: File.open("app/assets/images/events/sample/#{get_random_image('app/assets/images/events/sample/')}"), filename: get_random_image('app/assets/images/events/sample/'))

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
