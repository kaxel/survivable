class Project < ApplicationRecord
  
  has_and_belongs_to_many :collections
  has_many :project_requirements
  has_many :adjustments
  
  @defaults = [
    "Twine",
    "Hook",
    "Knife",
    "Lean To",
    "Log Cabin",
    "Bed",
    "Fireplace",
    "Pit House",
    "Smoker",
    "Net",
    "Firestarter",
    "Fire",
    "Cook Food"
  ]
  
  def requirements_met?(game)
    must_be_all_true = []

    self.requirements.each do |pr|
      puts "#{pr.resource.name} of #{pr.amount}"
      #check stash
      stashed = game.stashes.where(name: pr.resource.name).where("quantity >= :quant", quant: pr.amount).first
      #check possessions
      possessed = game.possessions.where(name: pr.resource.name).where("quantity >= :quant", quant: pr.amount).first
      if (stashed || possessed)
        must_be_all_true << true
      else
        must_be_all_true << false
      end
    end

    !must_be_all_true.include? false
  end
  
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
  
  def requirements
    ProjectRequirement.where(project_id: self.id).map {|p| p.requirement}
  end
  
end
