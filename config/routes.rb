Rails.application.routes.draw do
  devise_for :sellers do
    root :to => "sellers#index"
    end
  devise_for :users
  root 'mains#index'
  get 'mains/user_page'
  
  resources :users do
    get :login, on: :collection
    get :profile, on: :collection
  end 

  resources :sellers do
    get :seller_products, on: :member
    get :seller_page, on: :collection
    get :login, on: :collection
    get :seller_list, on: :collection
  end
  resources :products
  resources :carts do
    post :insert, to: 'carts#insert', on: :collection
  end
  resources :payments
  resources :orders
end
