class AddLevelIdToExam < ActiveRecord::Migration[7.0]
  def change
    add_column :exams, :level_id, :integer
    add_index :exams, :level_id, unique: true
  end
end
