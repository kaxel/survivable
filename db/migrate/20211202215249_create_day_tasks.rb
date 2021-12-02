class CreateDayTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :day_tasks do |t|
      t.integer :num, limit: 2
      t.references :day, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
