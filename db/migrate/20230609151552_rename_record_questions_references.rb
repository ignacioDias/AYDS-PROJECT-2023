# frozen_string_literal: true

class RenameRecordQuestionsReferences < ActiveRecord::Migration[7.0]
  def change
    rename_column :record_questions, :records_id, :record_id
    rename_column :record_questions, :questions_id, :question_id
  end
end
