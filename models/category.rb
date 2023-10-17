class Category < ActiveRecord::Base
  has_one :exam
  has_many :levels
end
