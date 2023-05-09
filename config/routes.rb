Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get "/user", to: "users#show"
  resources :items, only: [:new, :create, :show]
  resources :auction_lots, only: [:new, :create, :show, :index] do
    resources :lot_items, only: [:new, :create]
    resources :bids, only: [:new, :create]
    post 'approved', on: :member
    post 'closed', on: :member
    post 'canceled', on: :member
    get 'expired', on: :collection
    get 'closed_list', on: :collection
    post 'favorite', on: :member
    delete 'unfavorite', on: :member
  end
  resources :blocked_cpfs, only: [:new, :create, :index]
  get 'search', to: 'home#search'
end
