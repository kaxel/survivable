class Requirement < ApplicationRecord
  belongs_to :resource
  
  def self.load_default
    defaults = [
      ["Twine", "Leaves", 2],
      ["Twine", "Grass", 2],
      ["Hook", "Wire", 1],
      ["Knife", "Metal", 2],
      ["Knife", "Wood", 1],
      ["Lean To", "Wood", 4],
      ["Lean To", "Leaves", 4],
      ["Log Cabin", "Wood", 8],
      ["Log Cabin", "Leaves", 1],
      ["Log Cabin", "Mud", 5],
      ["Pit House", "Wood", 10],
      ["Pit House", "Leaves", 1],
      ["Pit House", "Mud", 6],
      ["A Frame", "Wood", 8],
      ["A Frame", "Leaves", 4],
      ["A Frame", "Mud", 4],
      ["Bed", "Wood", 4],
      ["Bed", "Leaves", 2],
      ["Fireplace", "Stone", 6]
    ]
    
    defaults.each do |d|
      proj = Project.where(name: d[0]).first
      res = Resource.where(name: d[1]).first
      Requirement.new(:name => "#{proj.name} - #{res.name}", :amount => d[2]).save
    end
    "Resources loaded"
    
  end
  
  def self.destroy_default
    Requirement.delete_all
    "Requirements delete all"
  end
end
