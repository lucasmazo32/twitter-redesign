class Opinion < ApplicationRecord
  before_save :languagefilter

  belongs_to :author, class_name: 'User'
  validates :text, presence: true, length: { in: 1..200 }

  private

  def languagefilter
    hate_filter = LanguageFilter::Filter.new(matchlist: :hate,
                                             replacement: :vowels)
    profanity_filter = LanguageFilter::Filter.new(matchlist: :profanity,
                                                  replacement: :garbled)
    self.text = hate_filter.sanitize(text)
    self.text = profanity_filter.sanitize(text)
  end
end
