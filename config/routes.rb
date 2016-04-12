Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get "/merchants/find", to: "merchants#find"
      get "/merchants/find_all", to: "merchants#find_all"
      resources :merchants, except: [:new, :edit]
    end
  end
end
