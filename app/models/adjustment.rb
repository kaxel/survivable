class Adjustment < ApplicationRecord
  belongs_to :project
  #
  # [
  #     "Twine",
  #     "Hook",
  #     "Knife",
  #     "Lean To",
  #     "Log Cabin",
  #     "Bed",
  #     "Fireplace",
  #     "Pit House",
  #     "A Frame"
  #   ]
  
  def self.load_default
    #  Lean To - comfort 3
    proj = Project.where(name: "Lean To").first
    Adjustment.new( project_id: proj.id, bonus: "comfort", amount: 3).save
    
    # Log Cabin - comfort 5
    proj = Project.where(name: "Log Cabin").first
    Adjustment.new( project_id: proj.id, bonus: "comfort", amount: 5).save
    
    # Pit House - comfort 9
    proj = Project.where(name: "Pit House").first
    Adjustment.new( project_id: proj.id, bonus: "comfort", amount: 9).save
    
    # A Frame - comfort 6
    proj = Project.where(name: "A Frame").first
    Adjustment.new( project_id: proj.id, bonus: "comfort", amount: 6).save
    
  end
  
  def self.destroy_default
    Adjustment.delete_all
    "Adjustments deleted"
  end
  
end
