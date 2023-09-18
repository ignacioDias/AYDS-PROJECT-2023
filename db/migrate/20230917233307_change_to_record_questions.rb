class ChangeToRecordQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_reference :record_questions, :questions, index: true
    add_column :record_questions, :questions_id, :integer
    add_foreign_key :record_questions, :questions, column: :question_id
  end
end
