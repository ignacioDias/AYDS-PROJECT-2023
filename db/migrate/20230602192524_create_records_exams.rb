class CreateRecordsExams < ActiveRecord::Migration[7.0]
  def change
    create_table :records_exams, id: false do |t|
      t.belongs_to :records
      t.belongs_to :exams
    end
    add_index :records_exams, [:record_id, :exam_id], unique: true
  end
end
