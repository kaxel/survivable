class Stash < ApplicationRecord
  belongs_to :current_game
  belongs_to :resource
end
