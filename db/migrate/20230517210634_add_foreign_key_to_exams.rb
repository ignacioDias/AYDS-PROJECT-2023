# frozen_string_literal: true

class AddForeignKeyToExams < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :exams, :levels
  end
end
