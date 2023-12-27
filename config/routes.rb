Rails.application.routes.draw do
  devise_for :users

  get 'home/index'

  get 'active_conversations/index'
  get 'messages/create'
  get 'users/index'

  resources :conversations, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end

  # Defines the root path route ("/")
  root "home#index"
end
