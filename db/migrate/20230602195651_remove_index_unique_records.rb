# frozen_string_literal: true

class RemoveIndexUniqueRecords < ActiveRecord::Migration[7.0]
  def change
    remove_index :records, column: :user_id, unique: true
  end
end
