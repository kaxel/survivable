class CreateStashes < ActiveRecord::Migration[6.1]
  def change
    create_table :stashes do |t|
      t.string :name
      t.references :current_game, null: false, foreign_key: true
      t.references :resource, null: false, foreign_key: true
      t.integer :quantity, limit: 2

      t.timestamps
    end
  end
end
