class AddLocationToCurrentGame < ActiveRecord::Migration[6.1]
  def change
    add_reference :current_games, :location, null: false, foreign_key: true
  end
end
