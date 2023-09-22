Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :merchants, only: [:update] do
    get '/dashboard' => 'merchants#show'
    resources :invoices, only: [:index, :show], :controller => 'merchant_invoices'
    resources :items, only: [:index, :show, :update, :new, :create], :controller => 'merchant_items'
    resources :discounts, only: [:index, :show, :new, :create]
  end

  resources :items, only: [:show, :edit, :update]

  resources :invoice_item, only: [:create, :update]

  namespace :admin do
    root :to => "admin#index"
    resources :merchants, only: [:index, :new, :show, :edit]
    post 'merchants/new' => 'merchants#create'
    patch 'merchants/:id/edit' => 'merchants#update', as: 'merchants_edit'
    resources :invoices, only: [:index, :show, :update]
  end
end
