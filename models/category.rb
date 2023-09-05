class Category < ActiveRecord::Base
  has_many :levels

  validate :must_have_at_least_one_level
  validate :valid_name
end
