class Project < ApplicationRecord
  
  @defaults = [
    "Twine",
    "Hook",
    "Knife",
    "Lean To",
    "Log Cabin",
    "Bed",
    "Fireplace",
    "Pit House",
    "A Frame"
  ]
  
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
