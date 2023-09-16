Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/merchants/:id/dashboard', to: 'merchants#show'

  resources :merchants, only: [] do
    resources :invoices, only: [:index, :show], :controller => 'merchant_invoices'
    resources :items, only: [:index, :show, :update], :controller => 'merchant_items'
  end

  resources :items, only: [:show, :edit, :update]

  resources :invoice_item, only: [:create, :update]

  namespace :admin do
    root :to => "admin#index"
    resources :merchants, only: [:index, :new, :create, :show, :edit, :update]
    resources :invoices, only: [:index, :show, :update]
  end
end
