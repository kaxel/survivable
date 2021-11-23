class Resource < ApplicationRecord
  
  
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
