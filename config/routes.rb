Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/merchants/:id/dashboard', to: 'merchants#show'
  get "/merchants/:id/items", to: "merchant_items#index"
  get "/merchants/:merchant_id/items/:id", to: "merchant_items#show", as: :merchant_item
  patch "merchants/:merchant_id/items/:id", to: "merchant_items#update"

  get "/items/:id", to: "items#show"
  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update"

  get "/admin", to: "admin#index"
  get "/admin/merchants", to: "admin_merchants#index"
  get "/admin/invoices", to: "admin_invoices#index"
  get "admin/invoices/:id", to: "admin_invoices#show"
end
