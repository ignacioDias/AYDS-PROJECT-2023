# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :question
      t.string :answer
      t.string :wrongAnswer1
      t.string :wrongAnswer3
      t.integer :pointQuestion
      t.timestamps
    end
  end
end
