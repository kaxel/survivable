class Resource < ApplicationRecord
  
  def self.input_new_resource(game, resource, amount=1)
    new_resource = Stash.new(current_game_id: game.id, resource_id: resource.id)
    new_resource.quantity = amount
    new_resource.name = resource.name
    new_resource.save
    new_resource
  end
  
  def self.decrement_resource(game, resource_name, amount=1)
    resource = Stash.where(current_game_id: game.id, name: resource_name).first
    resource.quantity-=amount
    if resource.quantity==0
      resource.delete
    end
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
      "Metal",
      "Twine",
      "Fire"
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
