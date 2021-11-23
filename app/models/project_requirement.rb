class ProjectRequirement < ApplicationRecord
  belongs_to :project
  belongs_to :requirement
  
  
  def load_default
    
  end
  
  def destroy_default
    
  end
  
end
