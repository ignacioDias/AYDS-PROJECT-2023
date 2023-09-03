class User < ActiveRecord::Base
  has_one :profile
  has_one :record

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email address" }
  validates :password, presence: true, length: { minimum: 5 }

  
end
