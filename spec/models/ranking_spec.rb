require_relative '../../models/init.rb'
require 'sinatra/activerecord'

RSpec.describe Ranking do
  describe 'validations' do
      
    it 'requires points equal to the profile points' do
      existing_user = User.create(username: 'existing_user', email:'test@example.com', password: '123123')
      existing_profile = Profile.create(user_id: existing_user.id, totalPoints: 25)
      ranking = Ranking.create(user_id: existing_user.id, points: 30)
      expect(ranking.valid?).to be_falsey
      expect(ranking.errors[:points]).to include ("inconsistency in points")
    end
  end
end