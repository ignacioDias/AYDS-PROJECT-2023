# frozen_string_literal: true

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
    return unless pointQuestion.to_i <= 0

    errors.add(:pointQuestion, 'must be a positive number')
  end

  def unique_answer
    array_answers = [answer.to_s.downcase, wrongAnswer1.to_s.downcase, wrongAnswer2.to_s.downcase,
                     wrongAnswer3.to_s.downcase]
    3.times do |_|
      ans = array_answers.shift
      errors.add(:answer, 'must be different answers') if array_answers.include?(ans)
    end
  end

  def self.next_question(user_id, level_id, _current_question_id)
    questions = Question.where(level_id: level_id).to_a.shuffle
    user = User.find(user_id)
    record = user.record
    record_questions_user = RecordQuestion.where(record_id: record.id, wrong: true)
    question_ids = record_questions_user.joins(:question).where(questions: { level_id: level_id }).pluck(:question_id)

    questions.each do |q|
      return q unless question_ids.include?(q.id)
    end
    nil
  end
end
