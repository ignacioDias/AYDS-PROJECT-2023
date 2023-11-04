# frozen_string_literal: true

class CreateRecordsLevels < ActiveRecord::Migration[7.0]
  def change
    create_table :records_levels, id: false do |t|
      t.belongs_to :records
      t.belongs_to :levels
    end
    add_index :records_levels, %i[record_id level_id], unique: true
  end
end
