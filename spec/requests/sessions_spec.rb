require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'Sessions' do
    it 'You should go to a page different from /login or /users/new' do
      get root_path
      expect(response).to have_http_status(302)
      get users_path
      expect(response).to have_http_status(302)
      get jlt_index_path
      expect(response).to have_http_status(302)
      get login_path
      expect(response).to render_template(:new)
    end

    it 'Should login with the right username' do
      user = User.first
      get login_path
      post login_path, params: { session: { username: user.username.to_s } }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include(user.name)
    end
  end
end
