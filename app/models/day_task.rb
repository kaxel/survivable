class DayTask < ApplicationRecord
  has_one :day
  belongs_to :event
  
  def update_message(m)
    self.message = m
    self.save
  end
  
end
