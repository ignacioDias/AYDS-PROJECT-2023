require_relative '../../models/init.rb'
require 'sinatra/activerecord'

RSpec.describe Question do
  describe 'validations' do
    let(:question) { Question.new }

    it 'requires a username' do
      user.username = ''
      expect(user.valid?).to be_falsey
      expect(user.errors[:username]).to include("can't be blank")
    end

    it 'requires a unique email' do
      existing_user = User.create(username: 'existing_user', email: 'test@example.com', password: 'password')
      user.email = existing_user.email
      expect(user.valid?).to be_falsey
      expect(user.errors[:email]).to include("has already been taken")
    end

    it 'requires a valid email format' do
      user.email = 'invalid_email'
      expect(user.valid?).to be_falsey
      expect(user.errors[:email]).to include("is not a valid email address")
    end

    it 'requires a password with minimum length' do
      user.password = '1234'
      expect(user.valid?).to be_falsey
      expect(user.errors[:password]).to include("is too short (minimum is 5 characters)")
    end

    it 'is valid with a username, email, and password' do
      user.username = 'test_user'
      user.email = 'test2@example.com'
      user.password = 'password'
      expect(user.valid?).to be_truthy
    end
  end
end
   
