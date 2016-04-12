Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get "/merchants/find", to: "merchants#find"
      get "/merchants/find_all", to: "merchants#find_all"
      get "/merchants/random", to: "merchants#random"
      resources :merchants, except: [:new, :edit]

      get '/customers/find', to: 'customers#find'
      get '/customers/find_all', to: 'customers#find_all'
      get '/customers/random', to: 'customers#random'
      resources :customers, except: [:new, :edit]

      get '/invoices/find', to: 'invoices#find'
      get '/invoices/find_all', to: 'invoices#find_all'
      get '/invoices/random', to: 'invoices#random'
      resources :invoices, except: [:new, :edit]

      get '/items/find', to: 'items#find'
      get '/items/find_all', to: 'items#find_all'
      get '/items/random', to: 'items#random'
      resources :items, except: [:new, :edit]

      get '/invoice_items/find', to: 'invoice_items#find'
      get '/invoice_items/find_all', to: 'invoice_items#find_all'
      get '/invoice_items/random', to: 'invoice_items#random'
      resources :invoice_items, except: [:new, :edit]

      get '/transactions/find', to: 'transactions#find'
      get '/transactions/find_all', to: 'transactions#find_all'
      get '/transactions/random', to: 'transactions#random'
      resources :transactions, except: [:new, :edit]
    end
  end
end
