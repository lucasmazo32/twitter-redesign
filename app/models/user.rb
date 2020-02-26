class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged
  after_save :default_photo
  after_save :default_cover

  validate :good_username

  has_many :opinions, foreign_key: 'author', class_name: 'Opinion', dependent: :destroy
  has_many :follows, foreign_key: 'follower', class_name: 'Following', dependent: :destroy
  has_many :followds, foreign_key: 'followed', class_name: 'Following', dependent: :destroy

  validates :username, presence: true, allow_blank: false,
                       uniqueness: { case_sensitive: false },
                       length: { in: 5..20 },
                       format: { without: /\s/, message: 'no spaces allowed' }
  validates :name, presence: true, allow_blank: nil, length: { in: 3..25 }

  def follows?(user)
    self.follows.find_by(followed: user)
  end

  def num_following
    return 0 unless follows.any?
    
    follows.count
  end

  def num_followers
    return 0 unless followds.any?

    followds.count
  end

  def num_jlts
    return 0 unless opinions.any?

    opinions.count
  end

  def network_tweets
    id_array = self.follows.map(&:followed_id) << id
    Opinion.where(author_id: id_array)
  end

  def random_wtf
    id_array = self.follows.map(&:followed_id) << id
    User.where.not(id: id_array).sample(3)
  end

  private

  def default_photo
    if photo.empty?
      self.photo = Faker::Avatar.image
      self.save
    end
  end

  def default_cover
    if coverimage.empty? 
      self.coverimage = [
        "https://farm8.staticflickr.com/7137/27443920573_f21dfc3205_b.jpg",
        "https://farm8.staticflickr.com/7291/27443775693_5360498bf0_b.jpg",
        "https://farm6.staticflickr.com/5803/22660804556_b640819f4f_b.jpg",
        "https://farm2.staticflickr.com/1539/24630607809_dac5522568_b.jpg",
        "https://farm8.staticflickr.com/7432/27439189814_3565467d5f_b.jpg",
        "https://live.staticflickr.com/3371/4576593240_f8e3fa7a72_b.jpg",
        "https://farm5.staticflickr.com/4730/24280020847_4756aa84f4_b.jpg",
        "https://farm8.staticflickr.com/7266/27443875023_f509d29178_b.jpg",
        "https://farm8.staticflickr.com/7899/46827561401_50275c9976_b.jpg"
      ].sample
      self.save
    end
  end

  def good_username
    prof_filter = LanguageFilter::Filter.new(
      matchlist: :profanity,
      replacement: :stars
    )
    return unless prof_filter.match? username

    errors.add(:username, "The following word(s) are forbidden: #{prof_filter.matched(username).join(', ')}")
  end
end
