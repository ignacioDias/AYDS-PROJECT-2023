class AddTimestampToRanking < ActiveRecord::Migration[7.0]
  def change
    add_timestamps :rankings
  end
end
