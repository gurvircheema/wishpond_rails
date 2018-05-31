Rails.application.routes.draw do
  root to: 'home#index'
  resources :home, only: [:index]
  resources :uploads, only: [:index, :create]
end
