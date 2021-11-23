class Climate < ApplicationRecord
  
  @default_climates = [
    {:name => "Rainy Hot Mild", :cold_warm => 40, :cold_floor => 45, :warm_ceiling => 110, :intensity => 50, :trend => 5}
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
    end
    "Climates loaded"
  end
  
  def self.destroy_default
    Climate.delete_all
    "Climates delete all"
  end
  
end
