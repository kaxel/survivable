class Logic < ApplicationRecord
  
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
    else
      #warming up
      message << "It's warming up. "
      if (game.temp + increment) > climate.warm_ceiling
        game.temp = climate.warm_ceiling
      else
        game.temp += increment
      end
    end
    game.save
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
        message << "You are feeling a bit chilly—a shelter would be nice."
      when game.temp > 25
        mood_penalty = 10
        message << "Your toes are freezing—a shelter would be nice. "
      else
        mood_penalty = 15
        message << "You are living in a freezer—try building a shelter. "
    end
    
    #mitigation strategies
    #comfort
    comfort_offset = 0
    game.possessions.each do |p|
      adj = Adjustment.where(project_id: p.project.id).where(bonus: "comfort").first
      if adj
        comfort_offset += adj.amount
        message << "Your #{p.project.name} cheers you up. "
      end
    end
    
    mood_penalty-=comfort_offset
    game.mood_adjust(mood_penalty)
    message
  end
  
  def self.nighly_fire_check(game)
    message = ""
    wood_stash = game.stashes.where(name: "Wood").first
    fire_possession = game.possessions.where(name: "Fire").first
    if fire_possession
      game.mood_up(2)
      if wood_stash && wood_stash.quantity >= 2
        message << "Your fire burned through the night. "
      elsif wood_stash && wood_stash.quantity >= 1
        message << "Your fire extinguished in the night. "
        fire_possession.delete
      end
      Resource.decrement_resource(game, "Wood", 2)
    else
      message << "A fire might cheer you up. "
    end
    message
  end
  
end