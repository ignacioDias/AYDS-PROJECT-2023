class Question < ActiveRecord::Base
  belongs_to :exam
  belongs_to :level
  has_many :record_questions
  has_many :records, through: :record_questions
end
