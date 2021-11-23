class Project < ApplicationRecord
  
  def self.load_default
    defaults = [
      "Twine",
      "Hook",
      "Knife",
      "Lean To",
      "Log Cabin",
      "Bed",
      "Fireplace"
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
