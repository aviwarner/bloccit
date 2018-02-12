# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'random_data'

5.times do
  User.create!(
  name:           RandomData.random_name,
  email:          RandomData.random_email,
  password:       RandomData.random_sentence
  )
end
users = User.all

15.times do
  Topic.create!(
    name:         RandomData.random_sentence,
    description:  RandomData.random_paragraph
  )
end
topics = Topic.all

50.times do
  post = Post.create!(
    user:         users.sample,
    topic:        topics.sample,
    title:        RandomData.random_sentence,
    body:         RandomData.random_paragraph
  )

  post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
  rand(1..10).times { post.votes.create!(value: [-1, 1].sample, user: users.sample) }
end
posts = Post.all

100.times do
  Comment.create!(
    user:         users.sample,
    post:         posts.sample,
    body:         RandomData.random_paragraph
  )
end

admin = User.create!(
  name:       "Admin User",
  email:      "admin@example.com",
  password:   "123456",
  role:       "admin"
)

member = User.create!(
  name:       "Member User",
  email:      "member@example.com",
  password:   "123456",
  role:       "member"
)

puts "Seed finished"
puts "#{User.count} users created, #{Topic.count} topics created, #{Post.count} posts created (with #{Vote.count} votes among them) and #{Comment.count} comments created."
