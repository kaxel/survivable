class CreateSurvivalists < ActiveRecord::Migration[6.1]
  def change
    create_table :survivalists do |t|
      t.integer :strength, limit: 2
      t.integer :creativity, limit: 2
      t.integer :determination, limit: 2
      t.integer :optimism, limit: 2
      t.integer :skill, limit: 2

      t.timestamps
    end
  end
end
