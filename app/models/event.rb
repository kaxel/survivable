class Event < ApplicationRecord
    
  def self.insert_starting_events(game)
    events = [
      {:name => "Explore", :duration => 1},
      {:name => "Gather Mud", :duration => 1},
      {:name => "Gather Leaves", :duration => 1},
      {:name => "Collect Wood", :duration => 1}
      # {:name => "Explore", :duration => 1},
      # {:name => "Set Camp", :duration => 1},
      # {:name => "Cut Firewood", :duration => 1},
      # {:name => "Build Fire", :duration => 1},
      # {:name => "Tend Fire", :duration => 1},
      # {:name => "Gather Mud", :duration => 1},
      # {:name => "Gather Leaves", :duration => 1},
      # {:name => "Build Smoker", :duration => 1},
      # {:name => "Make Bed", :duration => 1},
      # {:name => "Eat Food", :duration => 1}
    ]
    events.each do |ev|
      Event.new(:name => ev[:name], :length => ev[:duration], :current_game_id => game.id).save
    end
  end
  
  def self.delete_related(game_id)
     Event.where(["current_game_id = ?", game_id]).delete_all
  end
  
  def process(game)
    
    case name
      when "Explore"
        message = "You have explored. Nothing of interest was found."
      when "Gather Mud"
        x = 1
        message = "You spent an hour gathering mud. You found #{x} clumps of it."
        
      when "Gather Leaves"
        x = 1
        message = "You spent an hour gathering leaves. You found #{x} piles."
      when "Collect Firewood"
        x = 1
        message = "you spent an hour collecting wood. You found #{x} good logs."
    end
    
  end
  
end
