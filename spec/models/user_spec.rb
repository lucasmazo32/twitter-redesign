require 'rails_helper'

RSpec.describe User, type: :model do
  context 'username' do
    let(:user) { User.new(username: 'hello world', name: 'foobar') }

    it 'should not allow blank spaces in username' do
      expect(user.valid?).to be false
    end

    it 'should not save' do
      expect(user.save).to be false
    end

    it 'should be between 5 and 20 characters' do
      user.username = 'helo'
      expect(user.valid?).to be false
    end

    it 'should not save when less than 5 characters' do
      user.username = 'helo'
      expect(user.save).to be false
    end

    it 'should not have curse words' do
      user.username = 'motherfucker'
      expect(user.valid?).to be false
    end

    it 'should be valid when is correct' do
      user.username = 'hello'
      expect(user.valid?).to be true
    end
  end

  context 'name' do
    let(:user) { User.new(username: 'example', name: 'fo') }
    it 'should be have more than 3 characters' do
      expect(user.valid?).to be false
    end

    it 'should have less than 25 characters' do
      user.name = 'abcdefghijklmnopqrstuvwxyz'
      expect(user.valid?).to be false
    end

    it 'should save when is correct' do
      user.name = 'example'
      expect(user.valid?).to be true
    end
  end

  context 'follows?(user)' do
    let(:f_user) { User.create!(username: 'foobar200', name: 'test', photo: '', coverimage: '') }
    let(:f_user2) { User.create!(username: 'foobar300', name: 'test', photo: '', coverimage: '') }

    it 'if is following' do
      follower = f_user.follows.build(followed: f_user2)
      follower.save
      expect(f_user.follows?(f_user2)).to be_truthy
    end

    it 'if is false' do
      expect(f_user.follows?(f_user2)).to be_falsy
    end
  end

  context 'num_?' do
    let(:user) { User.first }

    it 'num_following tell the number of following' do
      following = user.follows.count
      expect(user.num_following).to equal(following)
    end

    it 'num_followers tell the number of followers' do
      followers = user.followds.count
      expect(user.num_followers).to equal(followers)
    end

    it 'num_jlts tell the number of jlts' do
      jlts = user.opinions.count
      expect(user.num_jlts).to equal(jlts)
    end
  end

  context 'other methods' do
    let(:user) { User.first }

    it '#network_tweets' do
      expect(user.network_tweets).to exist
    end

    it '#random_wtf' do
      expect(user.random_wtf.length).to be <= 3
    end

    it '#followers' do
      expect(user.followers.count).to equal(user.num_followers)
    end

    it '#following' do
      expect(user.following.count).to equal(user.num_following)
    end

    it '#search_param(param)' do
      expect(user.search_param('a')).to exist
    end

    it '#find_friends' do
      num_users = User.all.count - (user.follows.count + 1)
      expect(user.find_friends.count).to equal(num_users)
    end

    it '#popular' do
      expect(user.popular.count).to equal(4)
    end

    it '#followers3' do
      expect(user.followers3.count).to be <= 3
    end
  end
end
