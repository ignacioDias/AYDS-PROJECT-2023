# frozen_string_literal: true

class CreateRecordsNew < ActiveRecord::Migration[7.0]
  def change
    create_table :records, &:timestamps
  end
end
