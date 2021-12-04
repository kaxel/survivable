class AddActiveToCurrentGame < ActiveRecord::Migration[6.1]
  def change
    add_column :current_games, :active, :boolean, :default => true
  end
end
