class AddCurrentGameToDay < ActiveRecord::Migration[6.1]
  def change
    add_reference :days, :current_game, null: false, foreign_key: true
  end
end
