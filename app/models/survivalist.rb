class Survivalist < ApplicationRecord
  @defaults =
  [
    {
    :name => "defaultistan",
    :strength => 6,
    :creativity => 6, 
    :determination => 6, 
    :optimism => 6, 
    :skill => 6},
    {
    :name => "Furbooshio",
    :strength => 9,
    :creativity => 7, 
    :determination => 3, 
    :optimism => 3, 
    :skill => 8},
    {
    :name => "Jenny of the Valley",
    :strength => 4,
    :creativity => 7, 
    :determination => 8, 
    :optimism => 4, 
    :skill => 7},
    {
    :name => "Kate of the Mountain",
    :strength => 6,
    :creativity => 6, 
    :determination => 4, 
    :optimism => 5, 
    :skill => 9}
  ]
    
  def starting_mood_score
    optimism*10
  end
  
  def starting_hunger_score
    strength*10
  end
  
  def self.add_default(user_id)
    @defaults.each do |survivalist|
      
      Survivalist.new(:name => survivalist[:name],
                      :strength => survivalist[:strength],
                      :creativity => survivalist[:creativity],
                      :determination => survivalist[:determination],
                      :optimism => survivalist[:optimism],
                      :skill => survivalist[:skill],
                      :user_id => user_id).save
      
    end
    
  end
  
  def image_path
    name.gsub(" ", "-")
  end
  
end
