class RemoveMorningMessageFromCurrentGame < ActiveRecord::Migration[6.1]
  def change
    remove_column :current_games, :morning_message, :string
  end
end
