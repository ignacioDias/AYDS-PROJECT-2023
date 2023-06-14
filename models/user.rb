class User < ActiveRecord::Base
  has_one :profile
  has_one :record

  validates :username, presence: true
end
