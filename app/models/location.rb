class Location < ApplicationRecord
  belongs_to :climate
  belongs_to :collection
  has_and_belongs_to_many :animals
  
end
