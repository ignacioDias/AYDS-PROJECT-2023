class AddTimestampToUsers < ActiveRecord::Migration[7.0]
  def change
    add_timestamps :users
  end
end
