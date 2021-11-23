class Possession < ApplicationRecord
  belongs_to :current_game
  
  def self.delete_related(game_id)
     Possession.where(["current_game_id = ?", game_id]).delete_all
  end
  
end
