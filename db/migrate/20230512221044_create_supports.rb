class CreateSupports < ActiveRecord::Migration[7.0]
  def change
    create_table :supports do |s|
      s.string :help
      s.timestamps
    end
  end
end
