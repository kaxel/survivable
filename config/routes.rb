Rails.application.routes.draw do
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
end
