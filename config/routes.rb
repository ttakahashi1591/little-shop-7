Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/merchants/:id/invoices/:id', to: 'merchants_invoices#show'
  get '/merchants/:id/dashboard', to: 'merchants#show'
  get "/merchants/:id/items", to: "merchant_items#index"
  get "/merchants/:merchant_id/items/:id", to: "merchant_items#show", as: :merchant_item
  patch "merchants/:merchant_id/items/:id", to: "merchant_items#update"
  post "/merchants/:merchant_id/items/new", to: "items#new"
  get "/merchants/items/new", to: "items#new"
  post "/merchants/:merchant_id/items", to: "items#create"
  get "/items/:id", to: "items#show"
  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update"
  get "/admin", to: "admin#index"
  get "/admin/merchants", to: "admin_merchants#index"
  get "/admin/merchants/:id", to: "admin_merchants#show"
  get "/admin/merchants/:id/edit", to: "admin_merchants#edit"
  patch "/admin/merchants/:id", to: "admin_merchants#update"
  get "/admin/invoices", to: "admin_invoices#index"
  get "/admin/invoices/:id", to: "admin_invoices#show"
  patch "/admin/invoices/:id", to: "admin_invoices#update"
end
