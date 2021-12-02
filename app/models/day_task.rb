class DayTask < ApplicationRecord
  has_one :day
  belongs_to :event
end
