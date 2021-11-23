class CreateJoinTableCollectionsProjects < ActiveRecord::Migration[6.1]
  def change
    create_join_table :collections, :projects do |t|
      # t.index [:collection_id, :project_id]
      # t.index [:project_id, :collection_id]
    end
  end
end
