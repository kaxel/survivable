class CreateJoinTableAnimalsLocations < ActiveRecord::Migration[6.1]
  def change
    create_join_table :animals, :locations do |t|
      # t.index [:animal_id, :location_id]
      t.index [:location_id, :animal_id]
    end
  end
end
