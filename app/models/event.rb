class Event < ApplicationRecord
  
  
  def self.add_events_for_requirements_met(game)
    #look for requirements met
    collection = Collection.where(name: game.location.collection.name).first
    collection.projects.each do |p|
      if p.name != "Fire" #Fire is special case
        if p.requirements_met?(game)
          add_new_event_if_not_present(p.name, game)
        else
          self.hide_event_if_present(p, game)
        end
      end
    end
  end
  
  def self.insert_possession_related_events(game)
    events = [
      {:name => "Hunt", :requires => ["Knife"]},
      {:name => "Set Fish Hook", :requires => ["Hook"]},
      {:name => "Drop Net", :requires => ["Hook"]}
    ]
    events.each do |ev|
      if game.possessions.where(name: ev[:requires].join(",")).first
        add_new_event_if_not_present(ev[:name], game)
      end
    end
    
    #firestarter
    if !game.has_fire?
      if game.possessions.where(name: "Firestarter").first && game.stashes.where(name: "Wood").where("quantity > 0").first
        add_new_event_if_not_present("Start Fire", game)
      elsif game.stashes.where(name: "Wood").first
        add_new_event_if_not_present("Make Friction Fire", game)
      end
    end
  end
  
  def self.add_new_event_if_not_present(name, game, amount = 1)
    my_event = Event.where(name: name, current_game_id: game.id).first
    if !my_event
      Event.new(:name => name, :length => amount, :current_game_id => game.id).save
    else
      my_event.toggle_visible(true)
    end
  end
  
  def self.hide_event_if_present(project, game)
    my_event = Event.where(name: project.name, current_game_id: game.id).first
    if my_event
      my_event.toggle_visible(false)
    end
  end
    
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
        
        x = creativity_check(game.survivalist, 0.35, 2)
        if x[0]==0
          "You found nothing."
        else
          available = ["Meat", "Mud", "Leaves", "Wood", "Grass", "Stone", "Metal", "Wire"].sample
          game.add_resource(available, x[0])
          "You found some #{available}."
        end
        
      when "Gather Mud"
        x = skill_check(game.survivalist, 0.50, 3)
        if x[0]== 0
          "There was no good mud to be found."
        else
          game.add_resource("Mud", x[0])
          "You found #{x[0]} clump#{x[0]>1 ? 's' : ''} of mud."
        end
      when "Gather Leaves"
        x = skill_check(game.survivalist, 0.50, 3)
        if x[0]== 0
          "Not a lot of leaves around here."
        else
          game.add_resource("Leaves", x[0])
          "You found #{x[0]} pile#{x[0]>1 ? 's' : ''} of leaves."
        end
      when "Collect Wood"
        x = skill_check(game.survivalist, 0.50, 3)
        if x[0]== 0
          "There was no dry wood to be found."
        else
          game.add_resource("Wood", x[0])
          "You found #{x[0]} good log#{x[0]>1 ? 's' : ''}."
        end
      when "Hunt"
        consolations = ["You found nothing.", "Hunting ain't easy.", "No luck this time.", "Better luck next time."]
        message = consolations.sample #default
        #pull from climate intensity to adjust hunt frequency (typically 20-80 (higher is more difficult))
        hunt_root_chance = (100.00-game.location.climate.intensity)/100
        found_prey = strength_check(game.survivalist, hunt_root_chance)[0]==1
        if found_prey
          animal = game.location.animals.where(aclass: ["mammal", "bird", "reptile"]).sample
          x = skill_check(game.survivalist, 0.65, animal.meat) #50% root chance to get meat per meat integer
          if x[0]==0
            message = "You saw a #{animal.name} but it got away."
          else
            message = "You saw a #{animal.name} and took it down for #{x[0]} meat."
            game.add_resource("Meat", x[0])
          end
        end
        game.hunger_down(2) #hunting costs extra energy
        message
      when "Start Fire"
        x = skill_check(game.survivalist, 0.50, 1)
        if x[0]==1
          Possession.add_fire(game)
          Resource.decrement_resource(game, "Wood", 1)
          "That's a fire!"
        else
          consolations = ["Your fire did not start.", "Your kindling is wet.", "You're just not having any luck starting a fire today."]
          consolations.sample
        end
      when "Cook Food"
        if game.hunger<=80
          game.hunger_up(20)
        else
          game.hunger=100
          game.save
        end
        Resource.decrement_resource(game, "Meat", 1)
        game.mood_up(2)
        consolations = ["Delicious.", "That really hit the spot.", "Best meal ever."]
        consolations.sample
      when "Twine"
        Resource.add_if_existing(game, Resource.where(name: "Twine").first, 1)
        project = Project.where(name: "Twine").first
        puts " found twine project"
        ProjectRequirement.where(project_id: project.id).all.each do |pr|
          Resource.decrement_resource(game, pr.requirement.resource.name, pr.requirement.amount)
        end
        "You made some twine."
      
      when "Set Fish Hook"
      when "Drop Net"
      else #standard project build
        project = Project.where(name: self.name).first
        Possession.add_if_not_existing(game, project, 1)
        ProjectRequirement.where(project_id: project.id).all.each do |pr|
          Resource.decrement_resource(game, pr.requirement.resource.name, pr.requirement.amount)
        end
        "Your #{self.name} is a nice addition to camp!"
    end
    
  end
  
  def skill_check(player, root_chance, max_return = 1)
    #root_change s/b between 0 and 1
    i_return=0
    player_factor = (player.skill * player.creativity) #s/b between 1 and 100
    root_factor = root_chance*100
    for i in 1..max_return do
      #as many tries as we are given
      if rand(0..100)<((root_factor*player_factor)/100)
        i_return+=1
      end
    end
    
    if i_return==0
      [i_return, "Your attempt failed."]
    else
      [i_return, "Success!"]
    end
  end
  
  def strength_check(player, root_chance, max_return = 1)
    #root_change s/b between 0 and 1
    i_return=0
    player_factor = (player.skill * player.strength) #s/b between 1 and 100
    root_factor = root_chance*100
    for i in 1..max_return do
      #as many tries as we are given
      if rand(0..100)<((root_factor*player_factor)/100)
        i_return+=1
      end
    end
    
    if i_return==0
      [i_return, "Your attempt failed."]
    else
      [i_return, "Success!"]
    end
  end
  
  def creativity_check(player, root_chance, max_return = 1)
    #root_change s/b between 0 and 1
    i_return=0
    player_factor = (player.creativity * 10) #s/b between 1 and 100
    root_factor = root_chance*100
    for i in 1..max_return do
      #as many tries as we are given
      if rand(0..100)<((root_factor*player_factor)/100)
        i_return+=1
      end
    end
    
    if i_return==0
      [i_return, "Your attempt failed."]
    else
      [i_return, "Success!"]
    end
  end
  
  def toggle_visible(is_visible)
    self.visible = is_visible
    self.save
  end
  
end
