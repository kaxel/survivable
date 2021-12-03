class Stash < ApplicationRecord
  belongs_to :current_game
  belongs_to :resource
  
  
  def self.delete_related(game_id)
     Stash.where(["current_game_id = ?", game_id]).delete_all
  end
  
end
