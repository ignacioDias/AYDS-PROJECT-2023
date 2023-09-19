class AddUserIdToRankings < ActiveRecord::Migration[7.0]
  def change
    change_column :rankings, :username, :Integer
    rename_column :rankings, :username, :user_id
    add_index :rankings, :user_id, unique: true
  end
end
