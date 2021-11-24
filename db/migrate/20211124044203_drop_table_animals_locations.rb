class DropTableAnimalsLocations < ActiveRecord::Migration[6.1]
  def change
    drop_table :animals_locations
  end
end
