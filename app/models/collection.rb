class Collection < ApplicationRecord
  has_and_belongs_to_many :projects
  
  @default_collections = [
    {:name => "Hunting Kit"},
    {:name => "Fisherman's Pride"},
    {:name => "Desert"}
  ]
  
  def self.starting_collections
    Collection.where(name: ["Hunting Kit", "Fisherman's Pride"])
  end

  def self.load_default
    @default_collections.each do |d|
      x = Collection.new
      x.name = d[:name]
      #find projects
      case d[:name]
        when "Hunting Kit"
          p = Project.where(name: "Knife").first
          x.projects << p
          p = Project.where(name: "Firestarter").first
          x.projects << p
        when "Fisherman's Pride"
          p = Project.where(name: "Hook").first
          x.projects << p
          p = Project.where(name: "Net").first
          x.projects << p
        when "Desert"
          p = Project.where(name: "Knife").first
          x.projects << p
          p = Project.where(name: "Firestarter").first
          x.projects << p
          p = Project.where(name: "Twine").first
          x.projects << p
          p = Project.where(name: "Lean To").first
          x.projects << p
          p = Project.where(name: "Bed").first
          x.projects << p
          p = Project.where(name: "Smoker").first
          x.projects << p
          p = Project.where(name: "Net").first
          x.projects << p
          p = Project.where(name: "Well").first
          x.projects << p
          p = Project.where(name: "A Frame").first
          x.projects << p
      end
      x.save
    end
    
    #load full standard collection
    x = Collection.new
    x.name = "Standard"
    Project.list.each do |d|
      p = Project.where(name: d).first
      x.projects << p
    end
    x.save
    "Collections loaded"
  end
  
  def self.destroy_default
    Collection.delete_all
    "Collections delete all"
  end
  
end
