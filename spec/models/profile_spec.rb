require_relative '../../models/init.rb'
require 'sinatra/activerecord'

RSpec.describe Profile do
  describe 'validations' do
    let(:profile) { Profile.new }
    let(:user) { User.new }

    it 'requires a unique profile for each user' do
      test_profile = Profile.create(user_id: user.id)
      profile.user_id = user.id
      expect(profile.valid?).to be_falsey
      expect(profile.errors[:user_id]).to include("user has profile")
    end

    it 'requires a user' do
      profile.user_id = nil
      expect(profile.valid?).to be_falsey
      expect(profile.errors[:user_id]).to include("user should not be nil")
    end
  end
end

