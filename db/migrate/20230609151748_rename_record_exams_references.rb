class RenameRecordExamsReferences < ActiveRecord::Migration[7.0]
  def change
    rename_column :record_exams, :records_id, :record_id
    rename_column :record_exams, :exams_id, :exam_id
  end
end
