class AddLevelIdToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :level_id, :integer
    add_index :questions, :level_id, unique: true
  end
end
