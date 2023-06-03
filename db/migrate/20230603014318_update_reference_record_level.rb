class UpdateReferenceRecordLevel < ActiveRecord::Migration[7.0]
  def change
    remove_reference :record_levels, :record, null: false, foreign_key: true
    add_reference :record_levels, :records, null: false, foreign_key: true
  end
end
