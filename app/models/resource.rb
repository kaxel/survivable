class Resource < ApplicationRecord
  
  def self.input_new_resource(game, project, amount=1)
    new_resource = Resource.new(current_game_id: game.id, project_id: project.id)
    new_possession.quantity = amount
    new_possession.name = project.name
    new_possession.save
    new_possession
  end
  
  
  def self.load_default
    defaults = [
      "Wood",
      "Mud",
      "Fish",
      "Meat",
      "Hide",
      "Stone",
      "Leaves",
      "Grass",
      "Wire",
      "Metal"
    ]
    
    defaults.each do |d|
      Resource.new(:name => d).save
    end
    "Resources loaded"
  end
  
  def self.destroy_default
    Resource.delete_all
    "Resources delete all"
  end
  
  
end
