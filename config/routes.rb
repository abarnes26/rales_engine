Rails.application.routes.draw do
  namespace :api do
      namespace :v1 do
        namespace :customers do
          get "find", to: "find#show"
          get "find_all", to: "find#index"
          get "random", to: "find#random"
          get ":id/invoices", to: "invoices#index"
          get ":id/transactions", to: "transactions#index"
          get ":id/favorite_merchant", to: "favorite_merchant#show"
        end
        resources :customers, only: [:index, :show]

        namespace :items do
          get "find", to: "find#show"
          get "find_all", to: "find#index"
          get "random", to: "find#random"
          get ":id/invoice_items", to: "invoice_items#show"
          get ":id/merchant", to: "merchant#show"
          get "most_revenue", to: "most_revenue#index"
        end
        resources :items, only: [:index, :show]

        namespace :merchants do
          get "find", to: "find#show"
          get "find_all", to: "find#index"
          get "random", to: "find#random"
          get ":id/items", to: "items#index"
          get ":id/invoices", to: "invoices#index"
          get "most_revenue", to: "most_revenue#index"
          get "most_items", to: "most_items#index"
          get ":id/revenue", to: "revenue#show"
          get ":id/favorite_customer", to: "favorite_customer#show"
        end
        resources :merchants, only: [:index, :show]

        namespace :invoices do
          get "find", to: "find#show"
          get "find_all", to: "find#index"
          get "random", to: "find#random"
          get ":id/transactions", to: "transactions#index"
          get ":id/invoice_items", to: "invoice_items#show"
          get ":id/items", to: "items#index"
          get ":id/customer", to: "customer#show"
          get ":id/merchant", to: "merchant#show"
        end
        resources :invoices, only: [:index, :show]

        namespace :transactions do
          get "find", to: "find#show"
          get "find_all", to: "find#index"
          get "random", to: "find#random"
          get ":id/invoice", to: "invoice#show"
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
