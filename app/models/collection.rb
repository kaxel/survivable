class Collection < ApplicationRecord
  has_and_belongs_to_many :projects
  
  @default_collections = [
    {:name => "Standard"},
    {:name => "Fisherman's Pride"}
  ]

  def self.load_default
    @default_collections.each do |d|
      x = Collection.new
      x.name = d[:name]
      #find projects
      case d[:name]
        when "Standard"
          p = Project.where(name: "Knife").first
          x.projects << p
          p = Project.where(name: "Firestarter").first
          x.projects << p
          x.save
        when "Fisherman's Pride"
          p = Project.where(name: "Hook").first
          x.projects << p
          p = Project.where(name: "Net").first
          x.projects << p
          x.save
      end
      
      x.save
    end
    "Collections loaded"
  end
  
  def self.destroy_default
    Collection.delete_all
    "Collections delete all"
  end
  
end
