require 'rails_helper'

RSpec.describe Following, type: :model do
  it 'must have two valid users' do
    user1 = User.create!(username: 'foobar1', name: 'foobar', photo: '', coverimage: '')
    user2 = User.create!(username: 'foobar2', name: 'foobar', photo: '', coverimage: '')
    follow = user1.follows.build(followed: user2)
    expect(follow.valid?).to be true
    user1.delete
    user2.delete
  end
end
