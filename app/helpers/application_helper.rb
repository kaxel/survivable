module ApplicationHelper
  
  def data_modules
    
    [
      {:name => "Project", :load_link => "/load_default_project", :destroy_link => "/destroy_default_project"},
      {:name => "Resource", :load_link => "/load_default_resource", :destroy_link => "/destroy_default_resource"},
      {:name => "Requirement", :load_link => "/load_default_requirement", :destroy_link => "/destroy_default_requirement"},
      {:name => "Adjustment", :load_link => "/load_default_adjustment", :destroy_link => "/destroy_default_adjustment"},
      {:name => "ProjectRequirement", :load_link => "/load_default_project_requirement", :destroy_link => "/destroy_default_project_requirement"},
      {:name => "Climate", :load_link => "/load_default_climate", :destroy_link => "/destroy_default_climate"},
      {:name => "Collection", :load_link => "/load_default_collection", :destroy_link => "/destroy_default_collection"},
      {:name => "Animal", :load_link => "/load_default_animal", :destroy_link => "/destroy_default_animal"},
      {:name => "Location", :load_link => "/load_default_location", :destroy_link => "/destroy_default_location"},
    ]

  end
  
  def translate_hour(num)
    case true
    when num < 6
      return ["#{num+6}:00 AM", "Top of the morning to ya."]
    when num == 6
      return ["12:00 PM", "The sun is high."]
    when num < 11
      return ["#{(num-6)}:00 PM", "Good afternoon."]
    else
      return ["#{(num-6)}:00 PM", "You are almost out of sunlight."]
    end
  end
  
  
  
  
end
