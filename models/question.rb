class Question < ActiveRecord::Base
  belongs_to :exam
  belongs_to :level
  has_many :record_questions
  has_many :records, through: :record_questions

  validates :pointQuestion, presence: true
  validate :point_question_positive
  validates :question, presence: true

  private

  def point_question_positive
    if pointQuestion.to_i <= 0
      errors.add(:pointQuestion, "must be a positive number")
    end
  end
end
