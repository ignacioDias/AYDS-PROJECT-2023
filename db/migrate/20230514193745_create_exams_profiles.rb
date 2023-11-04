# frozen_string_literal: true

class CreateExamsProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :exams_profiles, id: false do |t|
      t.belongs_to :exams
      t.belongs_to :profiles
    end
    add_index :exams_profiles, %i[exams_id profiles_id], unique: true
  end
end
