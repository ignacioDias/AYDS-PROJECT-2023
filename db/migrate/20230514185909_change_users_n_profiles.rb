# frozen_string_literal: true

class ChangeUsersNProfiles < ActiveRecord::Migration[7.0]
  def change
    remove_column :profiles, :username
    add_column :users, :username, :string
  end
end
