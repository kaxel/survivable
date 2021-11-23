class Location < ApplicationRecord
  belongs_to :climate
  belongs_to :collection
end
