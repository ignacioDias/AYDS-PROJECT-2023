# frozen_string_literal: true

class CreateRecordLevels < ActiveRecord::Migration[7.0]
  def change
    create_table :record_levels do |t|
      t.references :record, null: false, foreign_key: true
      t.references :levels, null: false, foreign_key: true
      t.integer :total_points
      t.integer :total_tries
      t.timestamps
    end
  end
end
