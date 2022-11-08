Rails.application.routes.draw do
  devise_for :users
  resources :games
  get 'games/:id/new_build', to: 'games#new_build', as: 'new_build'
  post 'games/:id/builds', to: 'games#build', as: 'game_builds'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "games#index"
end
