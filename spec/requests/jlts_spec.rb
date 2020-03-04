require 'rails_helper'

RSpec.describe 'Jlts', type: :request do
  def log_in(user_id)
    user = User.find(user_id)
    get login_path
    post login_path, params: { session: { username: user.username.to_s } }
    follow_redirect!
    user
  end

  context 'Just Like That' do
    it 'it should show me some basic info' do
      user = log_in(1)
      expect(response.body).to include(user.name,
                                       '<span>Who to follow</span>',
                                       '<label for="opinion_text">Just Like That!</label>',
                                       '<p>Following</p>',
                                       user.num_followers.to_s,
                                       user.num_following.to_s)
    end

    it 'Going to /me should redirect me to my profile' do
      user = log_in(1)
      get user_path(user)
      expect(response.body).to include(user.num_followers.to_s,
                                       user.num_following.to_s,
                                       user.num_jlts.to_s,
                                       '<span>Who to follow</span>')
    end

    it 'Should go to another persons profile' do
      log_in(1)
      user2 = User.second
      get user_path(user2)
      expect(response.body).to include(user2.username,
                                       user2.num_followers.to_s,
                                       user2.num_following.to_s,
                                       user2.num_jlts.to_s)
    end
  end

  context 'Follow logic' do
    let(:user) { User.create!(username: 'foobar1000', name: 'test', photo: '', coverimage: '') }
    let(:user2) { User.create!(username: 'foobar2000', name: 'test', photo: '', coverimage: '') }

    it 'should follow' do
      log_in(user.id)
      test_follow = user.follows.build(followed: user2)
      test_follow.save
      get user_path(user2)
      post user_path(user2), params: { follow: 'unfollow' }
      follow_redirect!
      expect(response.body).to include('Stopped following')
    end

    it 'does something' do
      log_in(user.id)
      get user_path(user2)
      post user_path(user2), params: { follow: 'follow' }
      follow_redirect!
      expect(response.body).to include('Now following')
    end
  end

  context 'Search and main options' do
    def find_user(user = nil)
      cont = 1
      while user.nil?
        if User.find(cont).num_followers != 0
          user = User.find(cont) if User.find(cont).num_following != 0
        end
        cont += 1
      end
      user
    end

    let(:user) { find_user }

    it 'should use the search engine' do
      log_in(user.id)
      get "/users?q=a&user=#{user.username}"
      users = User.where('name LIKE ?', '%a%').or(User.where('username LIKE ?', '%a%'))
      sample_user = users.first(30).sample(1)[0]
      expect(response.body).to include(sample_user.name.gsub(/'/, '&#39;'))
    end

    it 'should see the following of the user' do
      log_in(user.id)
      get "/users?follow=following&user=#{user.username}"
      sample_user = user.following.first(30).sample(1)[0]
      expect(response.body).to include(sample_user.name.gsub(/'/, '&#39;'))
    end

    it 'should show me the followers for the user' do
      log_in(user.id)
      get "/users?follow=followers&user=#{user.username}"
      sample_user = user.followers.first(30).sample(1)[0]
      expect(response.body).to include(sample_user.name.gsub(/'/, '&#39;'))
    end
  end
end
