class Day < ApplicationRecord
  has_many :day_tasks
  
  
  def hour
    if day_tasks.last
      day_tasks.last.num
    else
      0
    end
  end
  
  # def day_tasks
  #   DayTask.where(day_id: self.id)
  # end
  
end
