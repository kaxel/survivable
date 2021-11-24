class Project < ApplicationRecord
  
  has_and_belongs_to_many :collections
  has_and_belongs_to_many :requirements
  
  @defaults = [
    "Twine",
    "Hook",
    "Knife",
    "Lean To",
    "Log Cabin",
    "Bed",
    "Fireplace",
    "Pit House",
    "A Frame",
    "Firewood",
    "Smoker",
    "Net",
    "Firestarter",
    "Well"
  ]
  

  
  #add new to Adjustment, Requirement, and ProjectRequirement
  
  def self.load_default
    @defaults.each do |d|
      Project.new(:name => d).save
    end
    "Projects loaded"
  end
  
  def self.destroy_default
    Project.delete_all
    "Projects delete all"
  end
  
  def self.list
    @defaults
  end
  
end
