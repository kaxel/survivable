class AddHungerToCurrentGame < ActiveRecord::Migration[6.1]
  def change
    add_column :current_games, :hunger, :integer, limit: 1
    add_column :current_games, :mood, :integer, limit: 1
  end
end
