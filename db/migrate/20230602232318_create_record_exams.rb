class CreateRecordExams < ActiveRecord::Migration[7.0]
  def change
    create_table :record_exams do |t|
      t.references :records, null: false, foreign_key: true
      t.references :exams, null: false, foreign_key: true
      t.integer :point
      t.integer :tries
      t.timestamps
    end
  end
end
