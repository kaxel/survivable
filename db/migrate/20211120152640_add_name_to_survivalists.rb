class AddNameToSurvivalists < ActiveRecord::Migration[6.1]
  def change
    add_column :survivalists, :name, :string
  end
end
