class AddExamIdToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :exam_id, :integer
    add_index :questions, :exam_id, unique: true
  end
end
