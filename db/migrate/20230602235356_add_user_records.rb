# frozen_string_literal: true

class AddUserRecords < ActiveRecord::Migration[7.0]
  def change
    add_reference :records, :user, foreign_key: true, unique: true
  end
end
