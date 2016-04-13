Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get '/merchants/find', to: 'merchants#find'
      get '/merchants/find_all', to: 'merchants#find_all'
      get '/merchants/random', to: 'merchants#random'
      resources :merchants, except: [:new, :edit]
      get 'merchants/:id/items', to: 'merchant_items#index'
      get 'merchants/:id/invoices', to: 'merchant_invoices#index'
      get 'merchants/:id/revenue', to: 'merchant_revenue#show'

      get '/customers/find', to: 'customers#find'
      get '/customers/find_all', to: 'customers#find_all'
      get '/customers/random', to: 'customers#random'
      resources :customers, except: [:new, :edit]
      get '/customers/:id/invoices', to: 'customer_invoices#show'
      get '/customers/:id/transactions', to: 'customer_transactions#show'

      get '/invoices/find', to: 'invoices#find'
      get '/invoices/find_all', to: 'invoices#find_all'
      get '/invoices/random', to: 'invoices#random'
      resources :invoices, except: [:new, :edit]
      get 'invoices/:id/transactions', to: 'invoice_transactions#index'
      get 'invoices/:id/invoice_items', to: 'invoice_invoice_items_#index'
      get 'invoices/:id/items', to: 'invoice_item_relationships#index'
      get 'invoices/:id/customer', to: 'invoice_customer#show'
      get 'invoices/:id/merchant', to: 'invoice_merchant#show'

      get '/items/find', to: 'items#find'
      get '/items/find_all', to: 'items#find_all'
      get '/items/random', to: 'items#random'
      resources :items, except: [:new, :edit]
      get '/items/:id/invoice_items', to: 'item_invoice_items#index'
      get '/items/:id/merchant', to: 'item_merchant#show'

      get '/invoice_items/find', to: 'invoice_items#find'
      get '/invoice_items/find_all', to: 'invoice_items#find_all'
      get '/invoice_items/random', to: 'invoice_items#random'
      resources :invoice_items, except: [:new, :edit]
      get '/invoice_items/:id/invoice', to: 'invoice_item_invoice#show'
      get '/invoice_items/:id/item', to: 'invoice_item_item#show'

      get '/transactions/find', to: 'transactions#find'
      get '/transactions/find_all', to: 'transactions#find_all'
      get '/transactions/random', to: 'transactions#random'
      resources :transactions, except: [:new, :edit]
      get '/transactions/:id/invoice', to: 'transaction_invoice#show'
    end
  end
end
