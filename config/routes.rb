Rails.application.routes.draw do
  resources :day_tasks
  resources :animals
  resources :locations
  resources :collections
  resources :climates
  resources :adjustments
  resources :project_requirements
  resources :requirements
  resources :resources
  resources :projects
  resources :possessions
  devise_for :users
  #devise_for :admins
  mount RailsAdmin::Engine => '/moar_info', as: 'rails_admin'
  resources :survivalists
  resources :days
  resources :current_games
  resources :events
  #root to: 'current_games#index'
  root 'welcome#index'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  
  #custom routes
  get "/add_default_survivalist", to: "survivalists#get_default"
  
  get "/my_admin", to: "my_admin#index"
  
  get "/load_default_project", to: "projects#load_default"
  get "/destroy_default_project", to: "projects#destroy_default"
  
  get "/load_default_resource", to: "resources#load_default"
  get "/destroy_default_resource", to: "resources#destroy_default"
  
  get "/load_default_requirement", to: "requirements#load_default"
  get "/destroy_default_requirement", to: "requirements#destroy_default"
  
  get "/load_default_adjustment", to: "adjustments#load_default"
  get "/destroy_default_adjustment", to: "adjustments#destroy_default"
  
  get "/load_default_project_requirement", to: "project_requirements#load_default"
  get "/destroy_default_project_requirement", to: "project_requirements#destroy_default"
  
  get "/delete_game", to: "current_games#delete_game"
  
  get "/load_default_climate", to: "climates#load_default"
  get "/destroy_default_climate", to: "climates#destroy_default"
  
  get "/load_default_collection", to: "collections#load_default"
  get "/destroy_default_collection", to: "collections#destroy_default"
  
  get "/load_default_location", to: "locations#load_default"
  get "/destroy_default_location", to: "locations#destroy_default"
  
  get "/load_default_animal", to: "animals#load_default"
  get "/destroy_default_animal", to: "animals#destroy_default"
  
  
  #new game ajax
  get "fetch_survivalist", to: "survivalists#fetch_for_new_game", as: 'fetch_survivalist'
  get "fetch_location", to: "locations#fetch_for_new_game", as: 'fetch_location'
  get "fetch_starting_possessions", to: "collections#fetch_for_new_game", as: 'fetch_starting_possessions'
  
  
  #gameplay
  get "gameplay", to: "current_games#gameplay", as: 'gameplay'
  get "add_next", to: "current_games#add_next", as: 'add_next'
  
end
