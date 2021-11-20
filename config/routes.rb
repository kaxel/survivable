Rails.application.routes.draw do
  resources :survivalists
  resources :days
  resources :current_games
  resources :events
  root to: 'current_games#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  
  #custom routes
  get "/add_default_survivalist", to: "survivalists#get_default"
end
