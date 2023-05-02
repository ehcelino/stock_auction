Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get "/user", to: "users#show"
end
