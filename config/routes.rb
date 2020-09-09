Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index' 
  resources :enterprises, only: [:index]
  resources :profiles, only: [:index, :show, :new, :create]
end
