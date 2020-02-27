require 'rails_helper'

RSpec.describe 'Jlts', type: :request do
  describe 'Just Like That' do
    def log_in(user_id)
      user = User.find(user_id)
      get login_path
      post login_path, params: { session: { username: user.username.to_s } }
      follow_redirect!
      user
    end

    it 'it should show me some basic info' do
      user = log_in(1)
      expect(response.body).to include(user.name)
      expect(response.body).to include('<span>Who to follow</span>')
      expect(response.body).to include('<label for="opinion_text">Just Like That!</label>')
      expect(response.body).to include('<p>Following</p>')
      expect(response.body).to include(user.num_followers.to_s)
      expect(response.body).to include(user.num_following.to_s)
    end

    it 'Going to /me should redirect me to my profile' do
      user = log_in(1)
      get '/me'
      expect(response).to redirect_to(me_path(user))
      follow_redirect!
      expect(response.body).to include(user.num_followers.to_s)
      expect(response.body).to include(user.num_following.to_s)
      expect(response.body).to include(user.num_jlts.to_s)
      expect(response.body).to include('<span>Who to follow</span>')
    end

    it 'Should go to another persons profile' do
      user = log_in(1)
      user2 = User.second
      get me_path(user2)
      expect(response).to render_template(:show)
      expect(response.body).to include(user2.username)
      expect(response.body).to include(user2.num_followers.to_s)
      expect(response.body).to include(user2.num_following.to_s)
      expect(response.body).to include(user2.num_jlts.to_s)
      if user.follows?(user2)
        expect(response.body).to include('clas="no-follow')
        post me_path(user2), params: { follow: 'unfollow' }
        follow_redirect!
        expect(response.body).to include('Stopped following')
      else
        expect(response.body).to include('class="yes-follow"')
        post me_path(user2), params: { follow: 'follow' }
        follow_redirect!
        expect(response.body).to include('Now following')
      end
    end

    it 'should use the search engine' do
      user = log_in(1)
      get "/users?q=a&user=#{user.username}"
      expect(response).to have_http_status(200)
      User.where('name LIKE ?', '%a%').or(User.where('username LIKE ?', '%a%')).each do |current_user|
        expect(response.body).to include(current_user.name.gsub(/'/, '&#39;'))
      end
      get "/users?follow=following&user=#{user.username}"
      user.following.each do |current_user|
        expect(response.body).to include(current_user.name.gsub(/'/, '&#39;'))
      end
      get "/users?follow=followers&user=#{user.username}"
      user.followers.each do |current_user|
        expect(response.body).to include(current_user.name.gsub(/'/, '&#39;'))
      end
    end
  end
end
