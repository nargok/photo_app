Rails.application.routes.draw do
  root 'photos#index'
  get 'photos/index'
  get 'login', to: 'sessions#new'

  resources :sessions, only: [:new, :create, :destroy]
end
