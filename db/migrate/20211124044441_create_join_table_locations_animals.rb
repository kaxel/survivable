class CreateJoinTableLocationsAnimals < ActiveRecord::Migration[6.1]
  def change
    create_join_table :locations, :animals do |t|
      # t.index [:location_id, :animal_id]
      # t.index [:animal_id, :location_id]
    end
  end
end
