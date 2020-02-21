class Opinion < ApplicationRecord
  belongs_to :author, class_name: 'User'
  validates :text, presence: true, length: { in: 1..200 }
end
