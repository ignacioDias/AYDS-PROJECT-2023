class ChangeExamReplaceLevelIdToCategoryId < ActiveRecord::Migration[7.0]
  def change
    remove_index :exams, column: :level_id if index_exists?(:exams, :level_id)
    remove_column :exams, :level_id
    add_column :exams, :category_id, :integer
    add_index :exams, :category_id, unique: true
  end
end
