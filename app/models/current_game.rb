class CurrentGame < ApplicationRecord
  belongs_to :survivalist
  belongs_to :user
  
  def earliest
    puts "search for game #{id}"
    if !Day.find_by(current_game_id: self.id)
      1
    else
      Day.where(["current_game_id = ?", self.id]).last.hour + 1
    end
  end
  
end
