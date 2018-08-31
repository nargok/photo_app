Rails.application.routes.draw do
  root 'photos#index'
  get 'photos/index'
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'

  resource :sessions, only: [:new, :create, :destroy]
end
