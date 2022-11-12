Rails.application.routes.draw do
  devise_for :users
  resources :games

  get 'games/:game_id/new_build', to: 'builds#new_build', as: 'new_build'
  post 'games/:game_id/builds', to: 'builds#build', as: 'game_builds'

  post 'games/:id/start', to: 'games#start', as: 'start_game'

  get 'games/:id/new_join', to: 'games#new_join', as: 'new_join'
  post 'games/:id/joins', to: 'games#join', as: 'game_joins'
  delete 'games/:id/joins/:join_id', to: 'games#destroy_join', as: 'destroy_join'

  get  'games/:game_id/new_auction', to: "auctions#new_auction", as: 'new_auction'
  post 'games/:game_id/start_auction', to: "auctions#start", as: "start_auction"

  get  'games/:game_id/new_bid', to: "auctions#new_bid", as: "new_bid"
  post 'games/:game_id/bid', to: "auctions#bid", as: "bid"
  post 'games/:game_id/pass', to: "auctions#pass", as: "pass"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "games#index"
end
