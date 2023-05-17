class AddLevelIdToQuestions < ActiveRecord::Migration[7.0]
  def change
    ## elimino la columna level_id que existia antes por otra migracion eliminada
    remove_column :questions, :level_id

    add_column :questions, :level_id, :integer
    add_foreign_key :questions, :levels
  end
end
