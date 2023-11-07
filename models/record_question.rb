# frozen_string_literal: true

class RecordQuestion < ActiveRecord::Base
  belongs_to :record
  belongs_to :question

  def self.add_record_question(user_id, level_id, current_question, current_point_question, is_correctly)
    user = User.find_by(id: user_id)
    record = user.record
    record_questions_user = RecordQuestion.where(record_id: record.id)
    question_ids = record_questions_user.where(wrong: true).joins(:question).where(questions: { level_id: level_id }).pluck(:question_id)
    if is_correctly
      unless question_ids.include?(current_question.id) # Verifico que no se registren 2 veces una respuesta correcta (SE PODRIA SOLUCIONAR CON VALIDACIONES)
        record_question = RecordQuestion.new(record_id: record.id, question_id: current_question.id,
                                             points: current_point_question)
        record_question.save
      end
    else
      record_question = RecordQuestion.new(record_id: record.id, question_id: current_question.id,
                                           points: current_point_question, wrong: false)
      record_question.save
    end
  end
end
