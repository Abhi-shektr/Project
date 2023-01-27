Rails.application.routes.draw do
  devise_for :sellers do
    root :to => "sellers#index"
  end
  devise_for :users do
    root :to => "mains#user_page"
  end
  root 'mains#index'
  get 'mains/user_page'
  
  resources :users do
    get :login, on: :collection
    get :profile, on: :collection
  end 

  resources :sellers do
    get :seller_page, on: :collection
    get :login, on: :collection
    get :seller_list, on: :collection
  end
  resources :products
  resources :carts do
    post :delete, on: :collection
    post :insert, to: 'carts#insert', on: :collection
  end
  resources :payments
  resources :orders
end
