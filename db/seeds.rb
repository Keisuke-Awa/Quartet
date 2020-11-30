# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

300.times do |n|
  name = Faker::Name.name
  email = "rails#{n+1}@sample.com"
  password = "password"
  User.create!(name: name, email: email, password: password)
end

Place.create!(name: "新宿")
Place.create!(name: "池袋")
Place.create!(name: "渋谷")

def rand_in_range(from, to)
  rand * (to - from) + from
end

def rand_time(from, to)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

300.times do |n|
  context = Faker::Lorem.sentence
  meet_at = rand_time(Time.now, 7.days.since)
  people = rand(6) + 1
  place_id = rand(Place.count) + 1
  user = User.find(n + 1)
  Meeting.create!(context: context, meet_at: meet_at, people: people, place_id: place_id, user_id: user.id)
end