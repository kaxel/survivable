class Requirement < ApplicationRecord
  belongs_to :resource
  
  def load_default
    
  end
  
  def destroy_default
    
  end
end
