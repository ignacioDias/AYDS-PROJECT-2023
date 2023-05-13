class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :description
      t.string :photo
      t.integer :totalPoints
      t.string :achievement
      t.timestamps
    end
  end
end
