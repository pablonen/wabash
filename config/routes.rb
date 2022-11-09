Rails.application.routes.draw do
  devise_for :users
  resources :games

  get 'games/:game_id/new_build', to: 'builds#new_build', as: 'new_build'
  post 'games/:game_id/builds', to: 'builds#build', as: 'game_builds'

  get 'games/:id/new_join', to: 'games#new_join', as: 'new_join'
  post 'games/:id/joins', to: 'games#join', as: 'game_joins'
  delete 'games/:id/joins/:join_id', to: 'games#destroy_join', as: 'destroy_join'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "games#index"
end
