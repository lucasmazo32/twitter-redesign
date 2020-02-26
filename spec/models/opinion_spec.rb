require 'rails_helper'

RSpec.describe Opinion, type: :model do
  describe 'text' do
    it 'should be shorter than 200 characters' do
      user = User.create!(username: 'foobar', name: 'example')
      phrase = 'This is just to check if the text actually can detect if it has more than 200 characters,
                which is the limit.'
      opinion = user.opinions.build
      opinion.text = phrase + phrase
      expect(opinion.valid?).to be false
      opinion.valid?
      expect(opinion.errors.messages).to include({ text: ['is too long (maximum is 200 characters)'] })
      user.delete
    end
  end
end
