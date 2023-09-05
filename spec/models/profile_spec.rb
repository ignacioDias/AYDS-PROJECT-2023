require_relative '../../models/init.rb'
require 'sinatra/activerecord'

RSpec.describe Profile do
  describe 'validations' do
    it 'requires a unique profile for each user' do
      user = User.create(username: 'userTest', email: 'UserTest@example.com', password: 'password')
      test_profile = Profile.create(user_id: user.id)
      profile = Profile.new(user_id: user.id)
      expect(profile.valid?).to be_falsey
      expect(profile.errors[:user_id]).to include("user has profile")
    end

    it 'requires a user' do
      profile = Profile.new
      expect(profile.valid?).to be_falsey
      expect(profile.errors[:user_id]).to include("user should not be nil")
    end
  end
end

