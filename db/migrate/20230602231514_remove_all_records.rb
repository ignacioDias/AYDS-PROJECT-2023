class RemoveAllRecords < ActiveRecord::Migration[7.0]
  def change
    drop_table :records
    drop_table :questions_records
    drop_table :exams_records
    drop_table :levels_records
  end
end
