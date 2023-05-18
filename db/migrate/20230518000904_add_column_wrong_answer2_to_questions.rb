class AddColumnWrongAnswer2ToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :wrongAnswer2, :string
  end
end
