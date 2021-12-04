class Climate < ApplicationRecord
  
  @default_climates = [
    {:name => "Rainy Hot Mild", :cold_warm => 40, :cold_floor => 45, :warm_ceiling => 100, :intensity => 50, :trend => 3},
    {:name => "Rainy Cold Brisk", :cold_warm => 70, :cold_floor => 0, :warm_ceiling => 85, :intensity => 80, :trend => -5},
    {:name => "Dry Hot Extreme", :cold_warm => 90, :cold_floor => 65, :warm_ceiling => 120, :intensity => 80, :trend => 6},
  ]

  def self.load_default
    @default_climates.each do |d|
      x = Climate.new
      x.name = d[:name]
      x.cold_warm = d[:cold_warm]
      x.cold_floor = d[:cold_floor]
      x.warm_ceiling = d[:warm_ceiling]
      x.intensity = d[:intensity]
      x.trend = d[:trend]
      x.save
    end
    "Climates loaded"
  end
  
  def self.destroy_default
    Climate.delete_all
    "Climates delete all"
  end
  
  def start_temp
    return (self.warm_ceiling-self.cold_floor)*(self.cold_warm/100.00)
  end
  
end
