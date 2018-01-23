Rails.application.routes.draw do
  namespace :api do
      namespace :v1 do
        resources :items, only: [:index, :show]
        resources :merchants, only: [:index, :show]
        resources :customer, only: [:index, :show]
        resources :invoice, only: [:index, :show]
        resources :transaction, only: [:index, :show]
      end
    end
  end
