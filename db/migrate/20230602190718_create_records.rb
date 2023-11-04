# frozen_string_literal: true

class CreateRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :records do |r|
      r.integer :points
      r.integer :user_id
      r.timestamps
    end
    add_index :records, :user_id, unique: true
  end
end
