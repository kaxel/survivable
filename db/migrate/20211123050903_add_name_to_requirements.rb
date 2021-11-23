class AddNameToRequirements < ActiveRecord::Migration[6.1]
  def change
    add_column :requirements, :name, :string
  end
end
