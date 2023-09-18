class AddColumnAndRemoveColumnToRecordQuestion < ActiveRecord::Migration[7.0]
  def change
    remove_column :record_questions, :tries
    add_column :record_questions, :wrong, :boolean, default: true
  end
end
