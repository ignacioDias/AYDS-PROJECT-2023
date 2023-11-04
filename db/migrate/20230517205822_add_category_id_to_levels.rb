# frozen_string_literal: true

class AddCategoryIdToLevels < ActiveRecord::Migration[7.0]
  def change
    # elimino la columna category id que existia por otra migracion eliminada
    remove_column :levels, :category_id

    add_column :levels, :category_id, :integer
    add_foreign_key :levels, :categories
  end
end
