class CreateAnimals < ActiveRecord::Migration[6.1]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :type
      t.integer :meat, limit: 1
      t.integer :difficulty, limit: 1

      t.timestamps
    end
  end
end
