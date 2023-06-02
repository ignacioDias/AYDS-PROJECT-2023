class Exam < ActiveRecord::Base
  belongs_to :level
  has_many :questions
  has_and_belongs_to_many :profiles
  has_and_belongs_to_many :records
end

