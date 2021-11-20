class AddCurrentGameToEvents < ActiveRecord::Migration[6.1]
  def change
    add_reference :events, :current_game, null: false, foreign_key: true
  end
end
