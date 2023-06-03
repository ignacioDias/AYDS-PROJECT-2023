class CreateRecordQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :record_questions do |t|
      t.references :records, null: false, foreign_key: true
      t.references :questions, null: false, foreign_key: true
      t.integer :points
      t.integer :tries

      t.timestamps
    end
  end
end
