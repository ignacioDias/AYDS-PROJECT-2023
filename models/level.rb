class Level < ActiveRecord::Base
  has_one :exam
  belongs_to :category
  has_many :questions
end

