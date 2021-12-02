class Possession < ApplicationRecord
  belongs_to :current_game
  
  def self.delete_related(game_id)
     Possession.where(["current_game_id = ?", game_id]).delete_all
  end
  
  def self.input_starter_possession(game, project)
    new_possession = Possession.new(current_game_id: game.id, project_id: project.id)
    new_possession.quantity = 1
    new_possession.name = project.name
    new_possession.save
    new_possession
  end
  
end
