class Location < ApplicationRecord
  belongs_to :climate
  belongs_to :collection
  has_and_belongs_to_many :animals
  
  @defaults = [
    {:name => "Black Lake", :climate => "Rainy Cold Brisk", :animals => "All", :collection => "Standard", :description => "This 12-mile-long lake is home to some of the best fishing in the world. Mild summers and cold winters are always punctuated with regular precipitation."},
    {:name => "Sonoran Desert", :climate => "Dry Hot Extreme", :animals => "Desert", :collection => "Desert", :description => "A desert climate is home to only a handful of animals. Finding food may be a problem. Also, the heat can be overwhelming."}
  ]
  
  
  def self.load_default
    @defaults.each do |d|
      collection = Collection.where(name: d[:collection]).first
      climate = Climate.where(name: d[:climate]).first
      Location.new(:name => d[:name], :collection_id => collection.id, :climate_id => climate.id, :description => d[:description]).save
      @location = Location.where(name: d[:name]).first
      case d[:animals]
        when "All"
          Animal.list.each do |a|
            animal = Animal.where(name: a[:name]).first
            @location.animals << animal
          end
          @location.save
        when "Desert"
          Animal.list.each do |a|
            if a[:aclass]=='reptile'
              animal = Animal.where(name: a[:name]).first
              @location.animals << animal
            end
          end
          #add a few more
          a = Animal.where(name: "Squirrel").first
          @location.animals << a
          a = Animal.where(name: "Fox").first
          @location.animals << a
          @location.save
      end
    end
    "Locations loaded"
  end
  
  def self.destroy_default
    Location.delete_all
    "Locations delete all"
  end
  
  def image_path
    name.gsub(" ", "-")
  end
  
end
