Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get "/user", to: "users#show"
  resources :items, only: [:new, :create]
  resources :auction_lots, only: [:new, :create, :show]
end
