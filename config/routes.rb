Rails.application.routes.draw do
  namespace :api do
      namespace :v1 do
        namespace :customers do
          get "find", to: "find#show"
          get "find_all", to: "find#index"
          get "random", to: "find#random"
          get ":id/invoices", to: "invoices#index"
          get ":id/transactions", to: "transactions#index"
        end
        resources :customers, only: [:index, :show]

        namespace :items do
          get "find", to: "find#show"
          get "find_all", to: "find#index"
          get "random", to: "find#random"
        end
        resources :items, only: [:index, :show]

        namespace :merchants do
          get "find", to: "find#show"
          get "find_all", to: "find#index"
          get "random", to: "find#random"
        end
        resources :merchants, only: [:index, :show]

        namespace :invoices do
          get "find", to: "find#show"
          get "find_all", to: "find#index"
          get "random", to: "find#random"
          get ":id/transactions", to: "transactions#index"
          get ":id/invoice_items", to: "invoiceitems#show"
          get ":id/items", to: "items#index"
          get ":id/customer", to: "customer#show"
          get ":id/merchant", to: "merchant#show"
        end
        resources :invoices, only: [:index, :show]

        namespace :transactions do
          get "find", to: "find#show"
          get "find_all", to: "find#index"
          get "random", to: "find#random"
        end
        resources :transactions, only: [:index, :show]

        namespace :invoice_items do
          get "find", to: "find#show"
          get "find_all", to: "find#index"
          get "random", to: "find#random"
          get ":id/invoice", to: "invoice#show"
          get ":id/item", to: "item#show"
        end
        resources :invoice_items, only: [:index, :show]
      end
    end
  end
