class Logic < ApplicationRecord
  
  CAMPFIRE_MOOD_BOOST = 6
  TROTLINE_ROOT_CHANCE = 0.90
  
  def self.evaluate_weather(game)
    climate = game.location.climate
    message = ""
    
    #chance to double
    if rand(0..100)<climate.intensity
      increment = (climate.trend*2)
      message << "The weather is unpredictable. "
    else
      increment = climate.trend
    end
    #move up or down
    rand_100 = rand(0..100)
    if climate.cold_warm > rand_100
      #getting colder
      message << "It's getting colder. "
      if (game.temp - increment) < climate.cold_floor
        game.temp = climate.cold_floor
      else
        game.temp -= increment
      end
      game.save
    else
      #warming up
      message << "It's warming up. "
      if (game.temp + increment) > climate.warm_ceiling
        game.temp = climate.warm_ceiling
      else
        game.temp += increment
      end
      game.save
    end
    
    message << comfort_check(game)
    message  
  end
  
  def self.comfort_check(game)
    message = ""
    mood_penalty = 0
    case true
      when game.temp > 85
        mood_penalty = 5
        message << "The heat is intense. "
      when game.temp > 65
        message << "You are feeling comfortable. "
      when game.temp > 45
        mood_penalty = 5
        message << "You are feeling a bit chilly. "
      when game.temp > 25
        mood_penalty = 10
        message << "Your toes are freezing. "
      else
        mood_penalty = 15
        message << "You are living in a freezer. "
    end
    
    #mitigation strategies
    #comfort
    comfort_offset = 0
    game.possessions.each do |p|
      adj = Adjustment.where(project_id: p.project.id).where(bonus: "comfort").first
      if adj
        comfort_offset += adj.amount
        puts "Your #{p.project.name} helps a bit (#{adj.amount}). "
        message << "Your #{p.project.name} helps a bit (#{adj.amount}). "
      end
    end
    new_adjust = mood_penalty-comfort_offset
    if new_adjust < 0
      game.mood_up(mood_penalty.abs())
    elsif new_adjust > 0
      game.mood_down(mood_penalty.abs())
    else
      #no adjustment
    end
    
    message
  end
  
  def self.nightly_fire_check(game)
    message = ""
    wood_stash = game.stashes.where(name: "Wood").first
    fire_possession = game.possessions.where(name: "Fire").first
    if fire_possession
      game.mood_up(CAMPFIRE_MOOD_BOOST)
      if wood_stash && wood_stash.quantity >= 2
        message << "Your fire burned through the night. "
        Resource.decrement_resource(game, "Wood", 2)
      elsif wood_stash && wood_stash.quantity >= 1
        message << "Your fire extinguished in the night. "
        fire_possession.delete
        Resource.decrement_resource(game, "Wood", 1)
      else
        message << "Your fire extinguished in the night. "
        fire_possession.delete
      end
      
    else
      message << "A fire might cheer you up. "
    end
    message
  end
  
  def self.nightly_fish_check(game)
    # check for trotline
    matching_stash = game.stashes.where(name: "Trotline Hook").where("quantity > 0").first
    caught_already = game.stashes.where(name: "Trotline Catch").where("quantity > 0").first
    
    if matching_stash && !(caught_already)
      ready_to_add = 0
      for iteration in 1..matching_stash.quantity
        #environment check
        if environment_check(game.location, TROTLINE_ROOT_CHANCE)
          ready_to_add+=1
        end
      end
      if ready_to_add > 0
        resource = Resource.where(name: "Trotline Catch").first
        Resource.add_if_existing(game, resource, ready_to_add)
      end
    end
    
    #check for gillnet
    
  end
  
  def self.uncooked_meat_tax(game)
    message = ""
    meat_tax = 0.60
    resource = Resource.where(name: "Meat").first
    stash = game.stashes.where(resource_id: resource.id).first
    if stash
      old_amount = stash.quantity
      new_amount = (old_amount * meat_tax).to_i
      if new_amount==0
        stash.delete
      else
        stash.quantity = new_amount
        stash.save
      end
      
      message << "Some of your uncooked meat went bad last night."
    end
    message
  end
  
  def self.environment_check(location, root_chance)
    #root_change s/b between 0 and 1
    i_return=0
    climate_factor = (100 - location.climate.intensity) #s/b between 1 and 100
    root_factor = root_chance*100
    if rand(0..100)<((root_factor*climate_factor)/100)
      return true
    else
      return false
    end
  end
  
  def self.game_over_check(game)
    return (game.hunger <= 0 || game.mood <= 0)
  end
  
  def self.win_check(game)
    return (game.latest_day.num >= game.maxdays)
  end
  
end