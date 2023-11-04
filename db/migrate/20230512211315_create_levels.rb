# frozen_string_literal: true

class CreateLevels < ActiveRecord::Migration[7.0]
  def change
    create_table :levels do |l|
      l.string :name
      l.integer :numLevel
      l.timestamps
    end
  end
end
