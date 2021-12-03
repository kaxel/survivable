class Animal < ApplicationRecord
  has_and_belongs_to_many :locations
  
  @defaults = [
    {:name => "Squirrel", :aclass => "mammal", :meat => "1", :difficulty => "3"},
    {:name => "Deer", :aclass => "mammal", :meat => "9", :difficulty => "7"},
    {:name => "Hog", :aclass => "mammal", :meat => "7", :difficulty => "8"},
    {:name => "Possum", :aclass => "mammal", :meat => "3", :difficulty => "5"},
    {:name => "Fox", :aclass => "mammal", :meat => "2", :difficulty => "5"},
    {:name => "Raccoon", :aclass => "mammal", :meat => "2", :difficulty => "4"},
    {:name => "Turkey", :aclass => "bird", :meat => "5", :difficulty => "5"},
    {:name => "Duck", :aclass => "bird", :meat => "2", :difficulty => "4"},
    {:name => "Catfish", :aclass => "fish", :meat => "3", :difficulty => "2"},
    {:name => "Pike", :aclass => "fish", :meat => "2", :difficulty => "3"},
    {:name => "Bass", :aclass => "fish", :meat => "3", :difficulty => "4"},
    {:name => "Perch", :aclass => "fish", :meat => "1", :difficulty => "2"},
    {:name => "Walleye", :aclass => "fish", :meat => "2", :difficulty => "4"},
    {:name => "Lizard", :aclass => "reptile", :meat => "2", :difficulty => "4"},
    {:name => "Turtle", :aclass => "reptile", :meat => "2", :difficulty => "4"},
    {:name => "Snake", :aclass => "reptile", :meat => "2", :difficulty => "4"},
  ]
  
  
  def self.load_default
    @defaults.each do |d|
      Animal.new(:name => d[:name], :aclass => d[:aclass], :meat => d[:meat], :difficulty => d[:difficulty]).save
    end
    "Animals loaded"
  end
  
  def self.destroy_default
    Animal.delete_all
    "Animals delete all"
  end
  
  def self.list
    @defaults
  end
  
  def self.animals_for_hunt
    
  end
  
end
