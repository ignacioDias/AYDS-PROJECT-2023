class Question < ActiveRecord::Base
  belongs_to :exam
  belongs_to :level
  has_many :record_questions
  has_many :records, through: :record_questions

  validates :pointQuestion, presence: true
  validate :point_question_positive
  validates :question, presence: true
  validate :unique_answer

  private

  def point_question_positive
    if pointQuestion.to_i <= 0
      errors.add(:pointQuestion, "must be a positive number")
    end
  end

  def unique_answer
    array_answers = [answer.to_s.downcase, wrongAnswer1.to_s.downcase, wrongAnswer2.to_s.downcase, wrongAnswer3.to_s.downcase]
    for ans in array_answers do
        array_answers.shift
        if array_answers.include?(ans)
          errors.add(:answer, "must be different answers")
        end
    end
  end
end
