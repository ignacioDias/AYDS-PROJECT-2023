# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :username
      t.string :description
      t.string :photo
      t.integer :totalPoints
      t.string :achievement
    end
  end
end
