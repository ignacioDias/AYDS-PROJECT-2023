class Record < ActiveRecord::Base
  belongs_to :user
  has_many :record_questions
  has_many :questions, through: :record_questions
  has_many :record_exams
  has_many :exams, through: :record_exams
  has_many :record_levels
  has_many :levels, through: :record_levels
end

