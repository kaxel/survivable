class Event < ApplicationRecord
  
  def self.insert_starting_events(game)
    events = [
      {:name => "Explore", :duration => 1},
      {:name => "Set Camp", :duration => 1},
      {:name => "Cut Firewood", :duration => 1},
      {:name => "Build Fire", :duration => 1},
      {:name => "Tend Fire", :duration => 1},
      {:name => "Gather Mud", :duration => 1},
      {:name => "Gather Leaves", :duration => 1},
      {:name => "Build Smoker", :duration => 1},
      {:name => "Make Bed", :duration => 1},
      {:name => "Eat Food", :duration => 1}
    ]
    events.each do |ev|
      
      Event.new(:name => ev[:name], :length => ev[:duration], :current_game_id => game.id).save
      
    end
    
    
  end
  
end
