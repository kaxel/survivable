class Project < ApplicationRecord
  
  def self.load_default
    defaults = [
      "Explore",
      "Set Camp",
      "Cut Firewood",
      "Build fire",
      "Tend fire",
      "Gather Mud",
      "Gather Leaves",
      "Build Smoker",
      "Make Bed",
      "Eat Food"
    ]
    
    defaults.each do |d|
      Project.new(:name => d).save
    end
    "Projects loaded"
  end
  
  def self.destroy_default
    Project.delete_all
    "Projects delete all"
  end
  
end
