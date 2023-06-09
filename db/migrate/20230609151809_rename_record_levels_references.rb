class RenameRecordLevelsReferences < ActiveRecord::Migration[7.0]
  def change
    rename_column :record_levels, :records_id, :record_id
    rename_column :record_levels, :levels_id, :level_id
  end
end
