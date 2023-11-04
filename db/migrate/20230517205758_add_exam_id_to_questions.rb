# frozen_string_literal: true

class AddExamIdToQuestions < ActiveRecord::Migration[7.0]
  def change
    ## elimino la columna exam_id que existia antes por una migracion eliminada
    remove_column :questions, :exam_id

    add_column :questions, :exam_id, :integer
    add_foreign_key :questions, :exams
  end
end
