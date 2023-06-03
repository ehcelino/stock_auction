Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get "/user", to: "users#show"
  resources :items, only: [:new, :create, :show, :index, :edit, :update]
  resources :auction_lots, only: [:new, :create, :show, :index, :edit, :update] do
    resources :lot_items, only: [:new, :create]
    resources :bids, only: [:new, :create]
    post 'approved', on: :member
    post 'closed', on: :member
    post 'canceled', on: :member
    get 'expired', on: :collection
    get 'closed_list', on: :collection
    post 'favorite', on: :member
    post 'delivered', on: :member
    get 'delivered_list', on: :collection
    delete 'unfavorite', on: :member
    get 'canceled_list', on: :collection
    resources :qnas, only: [:new, :create] do
      get 'answer', on: :member
      post 'answered', on: :member
      post 'hidden', on: :member
      post 'approved', on: :member
    end
  end
  resources :blocked_cpfs, only: [:new, :create, :index, :destroy]
  get 'search', to: 'home#search'
  get 'qna/index', to: 'qnas#index'
  post 'answerquestion', to: 'qnas#answer'
  resources :categories, only: [:new, :create, :index]
end
