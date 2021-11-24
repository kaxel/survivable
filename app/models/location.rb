class Location < ApplicationRecord
  belongs_to :climate
  belongs_to :collection
  has_and_belongs_to_many :animals
  
  
  def self.load_default
    @defaults.each do |d|
      Project.new(:name => d).save
    end
    "Projects loaded"
  end
  
  def self.destroy_default
    Project.delete_all
    "Projects delete all"
  end
  
end
