module ApplicationHelper
  
  def data_modules
    
    [
      {:name => "Project", :load_link => "/load_default_project", :destroy_link => "/destroy_default_project"},
      {:name => "Resource", :load_link => "/load_default_resource", :destroy_link => "/destroy_default_resource"},
      {:name => "Requirement", :load_link => "/load_default_requirement", :destroy_link => "/destroy_default_requirement"},
      {:name => "Adjustment", :load_link => "/load_default_adjustment", :destroy_link => "/destroy_default_adjustment"},
      {:name => "ProjectRequirement", :load_link => "/load_default_project_requirement", :destroy_link => "/destroy_default_project_requirement"},
      {:name => "Climate", :load_link => "/load_default_climate", :destroy_link => "/destroy_default_climate"},
      {:name => "Collection", :load_link => "/load_default_collection", :destroy_link => "/destroy_default_collection"}
    ]

  end
  
end
