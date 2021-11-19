Rails.application.routes.draw do
  resources :days
  resources :current_games
  resources :events
  root to: 'events#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
