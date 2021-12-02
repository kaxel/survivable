class DayTask < ApplicationRecord
  belongs_to :day
  belongs_to :event
end
