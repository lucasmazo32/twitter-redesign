class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged

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
    follows.group(:follower_id).count[id]
  end

  def num_followers
    followds.group(:followed_id).count[id]
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

  def good_username
    prof_filter = LanguageFilter::Filter.new(
      matchlist: :profanity,
      replacement: :stars
    )
    return unless prof_filter.match? username

    errors.add(:username, "The following word(s) are forbidden: #{prof_filter.matched(username).join(', ')}")
  end
end
