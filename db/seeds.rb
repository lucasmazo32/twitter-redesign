# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'whirly'

Whirly.configure spinner: 'dots'

Whirly.start do
  Whirly.status = 'Creating users'
  30.times do
    username = Faker::Twitter.screen_name
    if username.length < 5
      username = Faker::Twitter.screen_name while username.length < 5
    end
    name = Faker::Name.first_name + ' ' + Faker::Name.last_name
    photo = Faker::Avatar.image
    User.create!(
      username: username,
      name: name,
      photo: photo
    )
  end
end

Whirly.start do
  Whirly.status = 'Creating opinions'
  50.times do
    ran_num = rand(4)
    case ran_num
    when 1
      quote = Faker::Quote.famous_last_words
    when 2
      quote = Faker::Quote.matz
    when 3
      quote = Faker::Quote.most_interesting_man_in_the_world
    else
      quote = Faker::Quote.yoda
    end
    user_id = rand(1..30)
    opinion = Opinion.new(author_id: user_id, text: quote)
    opinion.save if opinion.valid?
  end
end

Whirly.start do
  Whirly.status = 'Creating Following'
  100.times do
    follower_id = rand(1..30)
    followed_id = rand(1..30)
    if followed_id == follower_id
      followed_id = rand(1..30) while followed_id == follower_id
    end
    next if Following.where(follower_id: follower_id).find_by(followed_id: followed_id)
    Following.create!(follower_id: follower_id, followed_id: followed_id)
  end
end