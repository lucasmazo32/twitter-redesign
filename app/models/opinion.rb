class Opinion < ApplicationRecord
  before_save :languagefilter

  belongs_to :author, class_name: 'User'
  validates :text, presence: true, length: { in: 1..200 }

  def link_jlt
    scanned = text.scan(/jlt_\w+/)
    return self.text if scanned.empty?
    scanned = scanned.map{ |x| x[4...x.length] }
    scanned.each do |username|
      if user = User.find_by(username: username)
        text = "<a href='/me/#{username}'>jlt_#{username}</a>"
        self.text = self.text.gsub("jlt_#{username}", text)
      end
    end
    self.text.gsub(URI.regexp, '<a href="\0">\0</a>').html_safe
  end

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
