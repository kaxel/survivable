class CreateDays < ActiveRecord::Migration[6.1]
  def change
    create_table :days do |t|
      t.integer :hour, limit: 1
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
