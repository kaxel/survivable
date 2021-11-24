class ProjectRequirement < ApplicationRecord
  belongs_to :project
  belongs_to :requirement
  
  
  def self.load_default
    Requirement.list.each do |d|
      proj = Project.where(name: d[0]).first
      res = Resource.where(name: d[1]).first
      req = Requirement.where(name: "#{proj.name} - #{res.name}").first
      ProjectRequirement.new(:requirement_id => req.id, :project_id => proj.id).save
    end
    "ProjectRequirements loaded"
    
  end
  
  def self.destroy_default
    ProjectRequirement.delete_all
    "ProjectRequirements deleted"
  end
  
end
