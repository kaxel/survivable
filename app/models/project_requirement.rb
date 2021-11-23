class ProjectRequirement < ApplicationRecord
  belongs_to :project
  belongs_to :requirement
  
  
  def self.load_default
    Requirement.list.each do |d|
      puts "look for project: #{d[0]}"
      proj = Project.where(name: d[0]).first
      puts "look for resource: #{d[1]}"
      res = Resource.where(name: d[1]).first
      puts "look for requirement"
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
