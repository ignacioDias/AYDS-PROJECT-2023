class CreateRecordsNew < ActiveRecord::Migration[7.0]
  def change
    create_table :records do |r|
      r.timestamps
    end
  end
end
