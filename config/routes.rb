Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get "/merchants/find", to: "merchants#find"
      get "/merchants/find_all", to: "merchants#find_all"
      resources :merchants, except: [:new, :edit]

      get '/customers/find', to: 'customers#find'
      get '/customers/find_all', to: 'customers#find_all'
      resources :customers, except: [:new, :edit]

      get '/invoices/find', to: 'invoices#find'
      get '/invoices/find_all', to: 'invoices#find_all'
      resources :invoices, except: [:new, :edit]

      get '/items/find', to: 'items#find'
      get '/items/find_all', to: 'items#find_all'
      resources :items, except: [:new, :edit]

      get '/invoice_items/find', to: 'invoice_items#find'
      get '/invoice_items/find_all', to: 'invoice_items#find_all'
      resources :invoice_items, except: [:new, :edit]
    end
  end
end
