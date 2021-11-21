Rails.application.routes.draw do
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
end
