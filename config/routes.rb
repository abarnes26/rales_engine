Rails.application.routes.draw do
  namespace :api do
      namespace :v1 do
        namespace :customers do
          get "find", to: "find#show"
          get "find_all", to: "find#index"
        end
        resources :customers, only: [:index, :show]
        resources :items, only: [:index, :show]
        resources :merchants, only: [:index, :show]
        resources :invoices, only: [:index, :show]
        resources :transactions, only: [:index, :show]
        resources :invoice_items, only: [:index, :show]
      end
    end
  end
