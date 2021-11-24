class CreateJoinTableProjectsRequirements < ActiveRecord::Migration[6.1]
  def change
    create_join_table :projects, :requirements do |t|
      # t.index [:project_id, :requirement_id]
      # t.index [:requirement_id, :project_id]
    end
  end
end
