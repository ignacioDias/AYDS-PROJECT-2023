class User < ActiveRecord::Base
  has_one :profile
  has_one :record
end
