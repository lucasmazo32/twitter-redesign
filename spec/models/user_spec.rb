require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'username' do
    it 'should not allow blank spaces in username' do
      user = User.new(username: 'hello world', name: 'foobar')
      expect(user.valid?).to be false
      user.valid?
      expect(user.errors.messages).to include(username: ['no spaces allowed'])
      user.username = 'helloworld'
      expect(user.valid?).to be true
    end

    it 'should be between 5 and 20 characters' do
      user = User.new(username: 'helo', name: 'foobar')
      expect(user.valid?).to be false
      user.valid?
      expect(user.errors.messages).to include(username: ['is too short (minimum is 5 characters)'])
      user.username = 'helloworldthisisatestforthecharacters'
      expect(user.valid?).to be false
      user.valid?
      expect(user.errors.messages).to include(username: ['is too long (maximum is 20 characters)'])
    end

    it 'should not have curse words' do
      user = User.new(username: 'motherfucker', name: 'foobar')
      expect(user.valid?).to be false
    end
  end

  describe 'name' do
    it 'should be between 3 and 25 characters' do
      user = User.new(username: 'example', name: 'fo')
      expect(user.valid?).to be false
      user.valid?
      expect(user.errors.messages).to include(name: ['is too short (minimum is 3 characters)'])
      user.name = 'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopq'
      expect(user.valid?).to be false
      user.valid?
      expect(user.errors.messages).to include(name: ['is too long (maximum is 25 characters)'])
    end
  end
end
