class DayTask < ApplicationRecord
  belongs_to :day
  belongs_to :event
  
  def update_message(m)
    self.message = m
    self.save
  end
  
end
