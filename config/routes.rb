Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get "/user", to: "users#show"
  resources :items, only: [:new, :create]
  resources :auction_lots, only: [:new, :create, :show, :index] do
    resources :lot_items, only: [:new, :create]
    resources :bids, only: [:new, :create]
    post 'approved', on: :member
  end
end
