# frozen_string_literal: true

class User < ApplicationRecord
  has_many :opinions, foreign_key: 'author', class_name: 'Opinion'
  has_many :follows, foreign_key: 'follower', class_name: 'Opinion'
  has_many :followds, foreign_key: 'followed', class_name: 'Opinion'

  validates :username, presence: true, allow_blank: false,
                       uniqueness: { case_sensitive: false },
                       length: { in: 5..20 }
  validates :name, presence: true, allow_blank: nil, length: { in: 4..25 }
end
