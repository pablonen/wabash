Rails.application.routes.draw do
  resources :games
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "games#index"
end
