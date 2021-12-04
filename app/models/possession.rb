class Possession < ApplicationRecord
  belongs_to :current_game
  belongs_to :project
  
  def self.add_fire(game)
    if Possession.where(current_game_id: game.id, name: "Fire").first
      "Fire already present."
    else
      fire = Project.where(name: "Fire").first
      new_possession = Possession.new(current_game_id: game.id, project_id: fire.id)
      new_possession.quantity = 1
      new_possession.name = fire.name
      new_possession.save
      game.events.where("name LIKE '%Fire'").each {|e| e.toggle_visible(false)}
      new_possession
    end
  end
    
  def self.delete_related(game_id)
     Possession.where(["current_game_id = ?", game_id]).delete_all
  end
  
  def self.input_new_possession(game, project, amount)
    new_possession = Possession.new(current_game_id: game.id, project_id: project.id)
    new_possession.quantity = amount
    new_possession.name = project.name
    new_possession.save
    new_possession
  end
  
  def self.add_if_not_existing(game, project, amount)
    matching_project = Possession.where(current_game_id: game.id, project_id: project.id).first
    if matching_project
      #skip
    else
      Possession.input_new_possession(game, project, amount)
    end
  end
  
end
