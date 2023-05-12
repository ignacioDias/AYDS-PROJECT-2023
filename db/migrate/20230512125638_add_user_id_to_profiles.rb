class AddUserIdToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :user_id, :integer
    add_index :profiles, :user_id, unique: true
  end
end
