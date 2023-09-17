Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/merchants/:id/invoices', to: 'merchant_invoices#index'
  get '/merchants/:id/invoices/:id', to: 'merchant_invoices#show'
  get '/merchants/:id/dashboard', to: 'merchants#show'
  get "/merchants/:id/items", to: "merchant_items#index"
  get "/merchants/:id/items/new", to: "merchant_items#new"
  post "/merchants/:id/items", to: "merchant_items#create"
  get "/merchants/:merchant_id/items/:id", to: "merchant_items#show", as: :merchant_item
  patch "merchants/:merchant_id/items/:id", to: "merchant_items#update"
  get "/items/:id", to: "items#show"
  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update"
  get "/admin", to: "admin#index"
  get "/admin/merchants", to: "admin_merchants#index"
  get "/admin/merchants/new", to: "admin_merchants#new"
  post "/admin/merchants", to: "admin_merchants#create"
  get "/admin/merchants/:id", to: "admin_merchants#show"
  get "/admin/merchants/:id/edit", to: "admin_merchants#edit"
  patch "/admin/merchants/:id", to: "admin_merchants#update"
  get "/admin/invoices", to: "admin_invoices#index"
  get "/admin/invoices/:id", to: "admin_invoices#show"
  patch "/admin/invoices/:id", to: "admin_invoices#update"
  patch "merchants/:merchant_id/items/:id", to: "merchant_items#update"
  get "/items/:id", to: "items#show"
  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update"
end
