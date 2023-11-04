# frozen_string_literal: true

class AddColumnDescToCategories < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :descripcion
    add_column :categories, :description, :string
  end
end
