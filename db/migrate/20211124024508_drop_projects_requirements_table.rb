class DropProjectsRequirementsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :project_requirements
  end
end
