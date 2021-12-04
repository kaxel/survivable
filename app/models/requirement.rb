class Requirement < ApplicationRecord
  belongs_to :resource
  has_and_belongs_to_many :projects
  
  @defaults = [
    ["Twine", "Leaves", 2],
    ["Twine", "Grass", 2],
    ["Hook", "Wire", 1],
    ["Knife", "Metal", 2],
    ["Knife", "Wood", 1],
    ["Lean To", "Wood", 6],
    ["Lean To", "Leaves", 4],
    ["Bed", "Wood", 4],
    ["Bed", "Grass", 4],
    ["Log Cabin", "Wood", 8],
    ["Log Cabin", "Leaves", 2],
    ["Log Cabin", "Mud", 6],
    ["Pit House", "Wood", 10],
    ["Pit House", "Leaves", 4],
    ["Pit House", "Mud", 10],
    ["Bed", "Wood", 4],
    ["Bed", "Leaves", 2],
    ["Fireplace", "Stone", 6],
    ["Cook Food", "Meat", 1],
    ["Cook Food", "Fire", 1],
    ["Smoker", "Wood", 6],
    ["Smoker", "Leaves", 2],
    ["Net", "Twine", 4],
  ]
  
  def self.load_default
    
    @defaults.each do |d|
      #puts "look for project: #{d[0]}"
      proj = Project.where(name: d[0]).first
      #puts "look for resource: #{d[1]}"
      res = Resource.where(name: d[1]).first
      Requirement.new(:name => "#{proj.name} - #{res.name}", :resource_id => res.id, :amount => d[2]).save
    end
    "Requirements loaded"
    
  end
  
  def self.destroy_default
    Requirement.delete_all
    "Requirements delete all"
  end
  
  def self.list
    @defaults
  end
end
