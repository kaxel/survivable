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
  #   ]
  
  def self.load_default
    #  Lean To - comfort 3
    proj = Project.where(name: "Lean To").first
    Adjustment.new( project_id: proj.id, bonus: "comfort", amount: 4).save
    
    # Log Cabin - comfort 5
    proj = Project.where(name: "Log Cabin").first
    Adjustment.new( project_id: proj.id, bonus: "comfort", amount: 10).save
    
    # Pit House - comfort 9
    proj = Project.where(name: "Pit House").first
    Adjustment.new( project_id: proj.id, bonus: "comfort", amount: 14).save
    
    # fireplace
    proj = Project.where(name: "Fireplace").first
    Adjustment.new( project_id: proj.id, bonus: "comfort", amount: 4).save
    
    # bed
    proj = Project.where(name: "Bed").first
    Adjustment.new( project_id: proj.id, bonus: "comfort", amount: 4).save
    
    "Adjustments loaded"
  end
  
  def self.destroy_default
    Adjustment.delete_all
    "Adjustments deleted"
  end
  
end
