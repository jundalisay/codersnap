Rails.application.routes.draw do

  root 'messages#index'
  resources :messages
  get 'messages/received' => 'messages#received'
  get 'messages/sent' => 'messages#sent'
  # post '/' => 'messages#create'
  # resources :messages

  resources :users

  resources :sessions, only: [:new, :create, :destroy]
  # get 'register', to: 'user#new', as: 'new'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  

  delete 'logout' => 'sessions#destroy'



  resources :friendships
end
