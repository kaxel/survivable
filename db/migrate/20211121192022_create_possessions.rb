class CreatePossessions < ActiveRecord::Migration[6.1]
  def change
    create_table :possessions do |t|
      t.string :name
      t.string :bonus
      t.references :current_game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
