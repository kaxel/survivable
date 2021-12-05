class Event < ApplicationRecord
  
  EAT_FOOD_MOOD_BOOST = 10
  EAT_FOOD_HUNGER_BOOST = 20
  
  @possession_related_events = [
      {:name => "Hunt", :requires => ["Knife"], :stash_required => []},
      {:name => "Set Trotline", :requires => ["Hook"], :stash_required => ["Twine"]},
      {:name => "Drop Net", :requires => ["Net"], :stash_required => []},
      {:name => "Smoke Meat", :requires => ["Smoker", "Fire"], :stash_required => ["Meat", "Wood"]},
    ]
  
  def self.add_events_for_requirements_met(game)
    #look for requirements met
    collection = Collection.where(name: game.location.collection.name).first
    collection.projects.each do |p|
      if p.name != "Fire" #Fire is special case
        if p.requirements_met?(game) && !(Possession.where(project_id: p.id).first)
          add_new_event_if_not_present(p.name, game)
        else
          self.hide_event_if_present(p, game)
        end
      end
    end
  end
  
  def self.add_events_for_fishing(game)
    #look for existing trot lines
    matching_stash = game.stashes.where(name: "Trotline Hook").where("quantity > 0").first
    if matching_stash
      add_new_event_if_not_present("Check Trotline", game)
    end
    #look for existing gillnets
    matching_stash = game.stashes.where(name: "Gillnet").where("quantity > 0").first
    if matching_stash
      add_new_event_if_not_present("Check Gillnet", game)
    end
  end
  
  def self.insert_possession_related_events(game)
    @possession_related_events.each do |ev|
      all_requires = [] #true means req is met
      ev[:requires].each do |multi_req|
        if game.possessions.where(name: multi_req).first
          all_requires << true
        else
          all_requires << false
        end
      end
      ev[:stash_required].each do |req|
        if game.stashes.where(name: req).first
          all_requires << true
        else
          all_requires << false
        end
      end
      if !all_requires.include? false
        #meets stash requirements
        add_new_event_if_not_present(ev[:name], game)
      else
        #turn it off
        this_event = Event.where(name: ev[:name]).first
        if this_event then this_event.toggle_visible(false) end
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
      {:name => "Collect Wood", :duration => 1},
      {:name => "Gather Grass", :duration => 1},
      {:name => "Gather Stone", :duration => 1},
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
          ["You found nothing.", "You did a lot of walking and not much finding.", "You had a nice nature bath."].sample
        else
          available = ["Meat", "Mud", "Leaves", "Wood", "Grass", "Stone", "Metal", "Wire"].sample
          game.add_resource(available, x[0])
          "You found some #{available}."
        end
      when "Check Trotline"
        matching_stash = game.stashes.where(name: "Trotline Catch").where("quantity > 0").first
        if matching_stash
          num_caught = matching_stash.quantity
          #checking lines costs hunger
          game.hunger_down(num_caught)
          matching_stash.delete
          game.add_resource("Meat", num_caught)
          "You found #{num_caught} #{game.location.animals.where(aclass: "fish").sample.name} on your trotline."
        else
          game.hunger_down(2)
          "No fish on the trotline today."
        end
      when "Check Gillnet"
        matching_stash = game.stashes.where(name: "Gillnet Catch").where("quantity > 0").first
        if matching_stash
          num_caught = matching_stash.quantity
          #checking gillnets costs hunger
          game.hunger_down(num_caught)
          matching_stash.delete
          game.add_resource("Meat", num_caught)
          "You found #{num_caught} #{game.location.animals.where(aclass: "fish").sample.name} in your gillnet."
        else
          game.hunger_down(2)
          "No fish in the gillnet today."
        end
        
      when "Gather Mud"
        x = skill_check(game.survivalist, 0.50, 3)
        if x[0]== 0
          "There was no good mud to be found."
        else
          game.add_resource("Mud", x[0])
          "You found #{x[0]} clump#{x[0]>1 ? 's' : ''} of mud."
        end
      when "Gather Grass"
        x = skill_check(game.survivalist, 0.50, 3)
        if x[0]== 0
          "There was no good grass to be found."
        else
          game.add_resource("Grass", x[0])
          "You found #{x[0]} clump#{x[0]>1 ? 's' : ''} of grass."
        end
      when "Gather Leaves"
        x = skill_check(game.survivalist, 0.50, 3)
        if x[0]== 0
          "Not a lot of leaves around here."
        else
          game.add_resource("Leaves", x[0])
          "You found #{x[0]} pile#{x[0]>1 ? 's' : ''} of leaves."
        end
      when "Gather Stone"
        x = skill_check(game.survivalist, 0.35, 5)
        if x[0]== 0
          "Not a lot of stones around here."
        else
          game.add_resource("Stone", x[0])
          "You found #{x[0]} stone#{x[0]>1 ? 's' : ''} to build with."
        end
      when "Collect Wood"
        x = skill_check(game.survivalist, 0.60, 4)
        if x[0]== 0
          "There was no dry wood to be found."
        else
          game.add_resource("Wood", x[0])
          "You found #{x[0]} good log#{x[0]>1 ? 's' : ''}."
        end
      when "Smoke Meat"
        wood_stash = game.stashes.where(name: "Wood").first
        meat_stash = game.stashes.where(name: "Meat").first
        has_smoker = game.possessions.where(name: "Smoker").first
        has_fire = game.possessions.where(name: "Fire").first
        if wood_stash && meat_stash && has_smoker && has_fire
          Resource.decrement_resource(game, "Wood", 1)
          Resource.decrement_resource(game, "Meat", 1)
          game.add_resource("Jerky", 1)
          #self.toggle_visible(false)
          "You made some jerky."
        end
      when "Eat Jerky"
        jerky_stash = game.stashes.where(name: "Jerky").first
        if jerky_stash
          if game.hunger<=(100 - (EAT_FOOD_HUNGER_BOOST))
            game.hunger_up(EAT_FOOD_HUNGER_BOOST)
          else
            game.hunger=100
            game.save
          end
          game.mood_up(EAT_FOOD_MOOD_BOOST)
          Resource.decrement_resource(game, "Jerky", 1)
          "Yum."
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
        x = skill_check(game.survivalist, 0.75, 1)
        if x[0]==1
          Possession.add_fire(game)
          Resource.decrement_resource(game, "Wood", 1)
          "That's a fire!"
        else
          consolations = ["Your fire did not start.", "Your kindling is wet.", "You're just not having any luck starting a fire today."]
          consolations.sample
        end
      when "Make Friction Fire"
        x = skill_check(game.survivalist, 0.20, 1)
        if x[0]==1
          Possession.add_fire(game)
          Resource.decrement_resource(game, "Wood", 1)
          "That's a fire!"
        else
          consolations = ["Your fire did not start.", "Your kindling is wet.", "Friction fires take a lot of bushcraft.", "This is not going well."]
          consolations.sample
        end
      when "Cook Food"
        if game.hunger<=(100 - EAT_FOOD_HUNGER_BOOST)
          game.hunger_up(EAT_FOOD_HUNGER_BOOST)
        else
          game.hunger=100
          game.save
        end
        Resource.decrement_resource(game, "Meat", 1)
        game.mood_up(EAT_FOOD_MOOD_BOOST)
        consolations = ["Delicious.", "That really hit the spot.", "Best meal ever."]
        consolations.sample
      when "Twine"
        Resource.add_if_existing(game, Resource.where(name: "Twine").first, 1)
        project = Project.where(name: "Twine").first
        ProjectRequirement.where(project_id: project.id).all.each do |pr|
          Resource.decrement_resource(game, pr.requirement.resource.name, pr.requirement.amount)
        end
        "You made some twine."
      when "Set Trotline"
        Resource.add_if_existing(game, Resource.where(name: "Trotline Hook").first, 1)
        #decrement hook - possessions
        Possession.decrement_possession(game, Project.where(name: "Hook").first, 1)
        #decrement twine - stashes
        Resource.decrement_resource(game, "Twine", 1)
        #remove event
        self.toggle_visible(false)
        "You put a hook on your trotline."
      when "Drop Net"
        Resource.add_if_existing(game, Resource.where(name: "Gillnet").first, 1)
        #decrement hook - possessions
        Possession.decrement_possession(game, Project.where(name: "Net").first, 1)
        #remove event
        self.toggle_visible(false)
        "You dropped a gillnet."
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
