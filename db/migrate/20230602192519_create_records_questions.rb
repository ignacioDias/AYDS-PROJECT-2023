class CreateRecordsQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :records_questions, id: false do |t|
      t.belongs_to :records
      t.belongs_to :questions
    end
    add_index :records_questions, [:record_id, :question_id], unique: true
  end
end
