Rails.application.routes.draw do
  root to: 'home#index' 
  resources :enterprises, only: [:index]
end
