class CurrentGame < ApplicationRecord
  belongs_to :survivalist
  belongs_to :user
  belongs_to :location
  has_many :possessions
  has_many :stashes
  has_many :days
  has_many :events
  
  def add_possession(what, amount)
    possession_match = possessions.where(name: what).first
    #possession exists?
    if possession_match
      possession_match.quantity += amount
      possession_match.save
    else
      project = Project.where(name: what).first
      Possession.input_new_possession(self, project, amount)
    end
    "Possession #{what} added #{amount}"
  end
  
  def add_resource(what, amount)
    resource_match = stashes.where(name: what).first
    #resource exists?
    if resource_match
      resource_match.quantity += amount
      resource_match.save
      if resource_match.quantity <= 0
        #check for ghost resources
        resource_match.delete
      end
    else
      resource = Resource.where(name: what).first
      Resource.input_new_resource(self, resource, amount)
    end
    "Stash #{what} added #{amount}"
  end
  
  def latest_day
    Day.where(["current_game_id = ?", self.id]).order("num desc").first
  end
  
  def hunger_description
    case true
    when hunger > 85
      "You have a full belly"
    when hunger > 60
      "Pretty much satisfied."
    when hunger > 25
      "You are getting hungry"
    else
      "You are starving"
    end
  end
  
  def hunger_down(amount)
    self.hunger-=amount
    self.save
  end
  
  def hunger_up(amount)
    self.hunger+=amount
    self.save
  end
  
  def mood_down(amount)
    self.mood-=amount
    self.save
  end
  
  def mood_up(amount)
    self.mood+=amount
    self.save
  end
  
  def has_fire?
    return self.possessions.where(name: "Fire").first
  end
  
  def mood_description
    case true
    when mood > 85
      "Your joy is palpable"
    when mood > 60
      "You are content"
    when mood > 25
      "Unhappy"
    else
      "Ready to give up"
    end
  end
  
  def self.delete_game(id)
    @game = CurrentGame.find(id)
    #@survivalists = Survivalist.where(user_id: @game.user.id)
    @days = Day.where(current_game_id: @game.id)
    @stashes = Stash.where(current_game_id: @game.id)
    @possessions = Possession.where(current_game_id: @game.id)
    message = "game #{@game.id} deleted. #{@game.possessions.size} possessions, 
    #{@days.size} days, #{@stashes.size} stashes"
    
    
    Possession.delete_related(@game.id)
    Stash.delete_related(@game.id)
    @days.each do |d| 
      d.day_tasks.each do |dt|
        dt.delete
      end
    end
    @days.delete_all
    Event.delete_related(@game.id)
    
    @game.delete
    #@survivalists.delete_all
    
    message
  end
  
  def archive_game
    self.active = false
    self.save
  end
  
  
  def self.current(user_id)
    @current_game = CurrentGame.where(user_id: user_id).where(active: true).first
  end
  
end
