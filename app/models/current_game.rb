class CurrentGame < ApplicationRecord
  belongs_to :survivalist
  belongs_to :user
  belongs_to :location
  has_many :possessions
  has_many :days
  has_many :events
  
  def earliest
    puts "search for game #{id}"
    if !Day.find_by(current_game_id: self.id)
      1
    else
      Day.where(["current_game_id = ?", self.id]).last.hour + 1
    end
  end
  
  def latest_day
    Day.where(["current_game_id = ?", self.id]).order("num desc").first
  end
  
  def hunger_description
    case true
    when hunger > 85
      "You have a full belly"
    when hunger > 60
      "You could use a snack"
    when hunger > 25
      "You are getting hungry"
    else
      "You are starving"
    end
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
    @survivalists = Survivalist.where(user_id: @game.user.id)
    @days = Day.where(current_game_id: @game.id)
    @day_tasks = DayTask.where(day_id: [@days.map {|d| d.id}.join(", ")])
    message = "game #{@game.id} deleted. #{@game.possessions.size} possessions, #{@survivalists.size} survivalists, #{@days.size} days, #{@day_tasks.first ? @day_tasks.size : 0} day_tasks"
    
    Event.delete_related(@game.id)
    Possession.delete_related(@game.id)
    
    
    @days.delete_all
    @day_tasks.delete_all
    @game.delete
    @survivalists.delete_all
    
    message
  end
  
end
