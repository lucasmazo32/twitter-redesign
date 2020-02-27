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
  images = [
    "https://farm8.staticflickr.com/7137/27443920573_f21dfc3205_b.jpg",
    "https://farm8.staticflickr.com/7291/27443775693_5360498bf0_b.jpg",
    "https://farm6.staticflickr.com/5803/22660804556_b640819f4f_b.jpg",
    "https://farm2.staticflickr.com/1539/24630607809_dac5522568_b.jpg",
    "https://farm8.staticflickr.com/7432/27439189814_3565467d5f_b.jpg",
    "https://live.staticflickr.com/3371/4576593240_f8e3fa7a72_b.jpg",
    "https://farm5.staticflickr.com/4730/24280020847_4756aa84f4_b.jpg",
    "https://farm8.staticflickr.com/7266/27443875023_f509d29178_b.jpg",
    "https://farm8.staticflickr.com/7899/46827561401_50275c9976_b.jpg"
  ]
  80.times do
    username = Faker::Twitter.screen_name
    if username.length < 5
      username = Faker::Twitter.screen_name while username.length < 5
    end
    name = Faker::Name.first_name + ' ' + Faker::Name.last_name
    user = User.new(
      username: username,
      name: name,
      photo: '',
      coverimage: images.sample
    )
    if user.valid?
      user.save
    else
      user.username = Faker::Name.first_name.downcase
      return user.save if user.valid?

      user.username = Faker::FunnyName.name.downcase.gsub(/\s/,'_').gsub('.','') while !user.valid?
      user.save
    end
  end
end

Whirly.start do
  Whirly.status = 'Creating opinions'
  300.times do
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
    user_id = rand(1..80)
    cre_at = rand(1..360)
    opinion = Opinion.new(author_id: user_id, text: quote, created_at: cre_at.minutes.ago)
    opinion.save if opinion.valid? && opinion.text.length < 200
  end
end

Whirly.start do
  Whirly.status = 'Creating Following'
  300.times do
    follower_id = rand(1..80)
    followed_id = rand(1..80)
    if followed_id == follower_id
      followed_id = rand(1..80) while followed_id == follower_id
    end
    next if Following.where(follower_id: follower_id).find_by(followed_id: followed_id)
    Following.create!(follower_id: follower_id, followed_id: followed_id)
  end
end