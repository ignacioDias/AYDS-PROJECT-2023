# frozen_string_literal: true

class AddForeignKeyToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :profiles, :users
  end
end
