# frozen_string_literal: true

class AddColumnsToRanking < ActiveRecord::Migration[7.0]
  def change
    add_column :rankings, :username, :string
    add_column :rankings, :points, :integer
  end
end
