Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index' 
  resources :enterprises, only: [:index]
  resources :profiles, only: [:index, :show, :new, :create]
  resources :products, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    get 'search', on: :collection
    resource :comments, only: [:new, :create]
    resource :sales, only: [:new, :create]
  end
  resources :sales, only: [:index]
  namespace :api do
    namespace :v1 do
      resources :products, only: %i[index show create]
    end
  end
end