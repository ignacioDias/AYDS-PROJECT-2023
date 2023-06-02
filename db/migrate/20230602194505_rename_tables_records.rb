class RenameTablesRecords < ActiveRecord::Migration[7.0]
  def change
    rename_table :records_questions, :questions_records
    rename_table :records_exams, :exams_records
    rename_table :records_levels, :levels_records
  end
end
