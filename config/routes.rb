Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :merchants, only: [:show, :update] do
    get '/dashboard' => 'merchants#show'
    resources :invoices, only: [:index, :show], :controller => 'merchant_invoices'
    resources :items, only: [:index, :show, :update, :new, :create], :controller => 'merchant_items'
  end

  resources :items, only: [:show, :edit, :update]

  resources :invoice_item, only: [:create, :update]

  namespace :admin do
    root :to => "admin#index"
    resources :merchants, only: [:index, :new, :create, :show, :edit, :update]
    resources :invoices, only: [:index, :show, :update]
  end
end
