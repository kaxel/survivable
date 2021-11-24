class Animal < ApplicationRecord
  has_and_belongs_to_many :locations
  
  @defaults = [
    {:name => "Squirrel", :type => "mammal", :meat => "1", :difficulty => "3"},
    {:name => "Deer", :type => "mammal", :meat => "9", :difficulty => "7"},
    {:name => "Hog", :type => "mammal", :meat => "7", :difficulty => "8"},
    {:name => "Possum", :type => "mammal", :meat => "3", :difficulty => "5"},
    {:name => "Fox", :type => "mammal", :meat => "2", :difficulty => "5"},
    {:name => "Raccoon", :type => "mammal", :meat => "2", :difficulty => "4"},
    {:name => "Turkey", :type => "bird", :meat => "5", :difficulty => "5"},
    {:name => "Catfish", :type => "fish", :meat => "3", :difficulty => "2"},
    {:name => "Pike", :type => "fish", :meat => "2", :difficulty => "3"},
    {:name => "Bass", :type => "fish", :meat => "3", :difficulty => "4"},
    {:name => "Perch", :type => "fish", :meat => "1", :difficulty => "2"},
    {:name => "Walleye", :type => "fish", :meat => "2", :difficulty => "4"}
  ]
  
  
  def self.load_default
    @defaults.each do |d|
      Animal.new(:name => d[:name], :type => d[:type], :meat => d[:meat], :difficulty => d[:difficulty]).save
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
  
end
