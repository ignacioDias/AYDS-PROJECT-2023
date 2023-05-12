class CreateExams < ActiveRecord::Migration[7.0]
  def change
    create_table :exams do |e|
      e.integer :pointExam
      e.timestamps
    end
  end
end
