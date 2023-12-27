Rails.application.routes.draw do
  get 'messages/create'
  devise_for :users

  get 'users/index'
  get 'home/index'

  resources :conversation, only: [:index, :show, :create, :update] do
    resources :messages, only: [:create]
  end

  # Defines the root path route ("/")
  root "home#index"
end
