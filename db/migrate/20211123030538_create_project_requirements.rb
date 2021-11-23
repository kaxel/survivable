class CreateProjectRequirements < ActiveRecord::Migration[6.1]
  def change
    create_table :project_requirements do |t|
      t.references :project, null: false, foreign_key: true
      t.references :requirement, null: false, foreign_key: true

      t.timestamps
    end
  end
end
