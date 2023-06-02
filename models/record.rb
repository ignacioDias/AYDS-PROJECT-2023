class Record < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :questions
  has_and_belongs_to_many :exams
  has_and_belongs_to_many :levels
end

