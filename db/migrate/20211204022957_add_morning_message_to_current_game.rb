class AddMorningMessageToCurrentGame < ActiveRecord::Migration[6.1]
  def change
    add_column :current_games, :morning_message, :string
    add_column :current_games, :maxdays, :integer, limit: 2
  end
end
