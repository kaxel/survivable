class AddTempToCurrentGame < ActiveRecord::Migration[6.1]
  def change
    add_column :current_games, :temp, :integer, limit: 1
  end
end
