class CurrentGame < ApplicationRecord
  belongs_to :survivalist
  belongs_to :user
  has_many :possessions
  has_many :events
  
  def earliest
    puts "search for game #{id}"
    if !Day.find_by(current_game_id: self.id)
      1
    else
      Day.where(["current_game_id = ?", self.id]).last.hour + 1
    end
  end
  
  def self.delete_game(id)
    @game = CurrentGame.find(id)
    @survivalists = Survivalist.where(user_id: @game.user.id)
    message = "game #{@game.id} deleted. #{@game.events.size} events, #{@game.possessions.size} possessions, #{@survivalists.size} survivalists"
    
    Event.delete_related(@game.id)
    Possession.delete_related(@game.id)
    @game.delete
    @survivalists.delete_all
    
    message
  end
  
end
