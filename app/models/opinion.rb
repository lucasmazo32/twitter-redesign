class Opinion < ApplicationRecord
  before_save :languagefilter
  default_scope { order(created_at: :desc) }
  belongs_to :author, class_name: 'User'
  validates :text, presence: true, length: { in: 1..300 }
  self.per_page = 10

  def link_jlt
    scanned = text.scan(/jlt_\w+\s/)
    return text.gsub(URI::DEFAULT_PARSER.make_regexp, '<a href="\0">\0</a>').html_safe if scanned.empty?

    scanned = scanned.map { |x| x[4...x.length - 1] }
    scanned.each do |username|
      if User.find_by(username: username)
        text = "<a href='/users/#{username}'>jlt_#{username}</a>"
        self.text = self.text.gsub("jlt_#{username}", text)
      end
    end
    save
    self.text.gsub(URI::DEFAULT_PARSER.make_regexp, '<a href="\0">\0</a>').html_safe
  end

  def created_ago
    time = Time.now - created_at
    case time
    when 0..60
      '1 minute'
    when 120..3600
      "#{(time / 60).to_i} minutes"
    when 3600..86_400
      "#{(time / 3600).to_i}H"
    else
      created_at.strftime('%-d %^b')
    end
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
