class AddTimestampToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_timestamps :profiles
  end
end
