class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |c|
      c.string :name
      c.timestamps
    end
  end
end
