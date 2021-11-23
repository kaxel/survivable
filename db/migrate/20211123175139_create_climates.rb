class CreateClimates < ActiveRecord::Migration[6.1]
  def change
    create_table :climates do |t|
      t.string :name
      t.integer :cold_warm, limit: 1
      t.integer :cold_floor, limit: 1
      t.integer :warm_ceiling, limit: 1
      t.integer :intensity, limit: 1
      t.integer :trend, limit: 1

      t.timestamps
    end
  end
end
