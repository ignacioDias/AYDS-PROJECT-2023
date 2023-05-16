class AddCategoryIdToLevels < ActiveRecord::Migration[7.0]
  def change
    add_column :levels, :category_id, :integer
    add_index :levels, :category_id, unique: true
  end
end
