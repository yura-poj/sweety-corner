Rails.application.routes.draw do
  root "categories#index"

  get "cart" => "orders#cart"
  delete "destroy_cart" => "orders#destroy_cart"

  resources :products, only: [ :index, :show, :create, :update, :destroy, :new, :edit ] do
    member do
      post :add_to_cart
      post :remove_from_cart
      delete :destroy_from_cart
    end
  end

  resources :categories, only: [ :index, :show, :create, :update, :destroy, :new, :edit ]

  resources :orders, only: [ :index, :show ]

  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check
end
