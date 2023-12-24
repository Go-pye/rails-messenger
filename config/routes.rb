Rails.application.routes.draw do
  devise_for :users

  get 'users/index'
  get 'home/index'

  # Defines the root path route ("/")
  root "home#index"
end
