class Exam < ActiveRecord::Base
  belongs_to :level
  has_many :questions
end

