# frozen_string_literal: true

class RecordLevel < ActiveRecord::Base
  belongs_to :record
  belongs_to :level

  def self.levels_ids_completed(user_id)
    user = User.find(user_id)
    record = user.record
    return RecordLevel.where(record_id: record.id).pluck(:level_id)
  end

  def self.complete_levels(cat, user_id)
    levels = Level.where(category_id: cat.id)
    points = 0
    levels.each do |lvl|
      questions = Question.where(level_id: lvl.id)
      questions.each do |q|
        RecordQuestion.add_record_question(user_id, lvl.id, q, q.pointQuestion, true)
        points += q.pointQuestion
      end
      RecordLevel.add_record_level(lvl, user_id)
    end
    return points
  end

  def self.add_record_level(level, user_id)
    user = User.find(user_id)
    record = user.record
    records_questions = record.record_questions
    records_questions.joins(:question).where(questions: { level_id: level }).pluck(:question_id)
    score = 0
    records_questions.to_a.each do |rq|
      level_question = Question.find_by(id: rq.question_id).level
      score += rq.points if level_question.id == level.id
    end
    record_level = RecordLevel.new(record_id: record.id, level: level, total_points: score)
    record_level.save
  end
end
