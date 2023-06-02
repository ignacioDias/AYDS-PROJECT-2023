class Level < ActiveRecord::Base
  has_one :exam
  belongs_to :category
  has_many :questions
  has_and_belongs_to_many :records
end

