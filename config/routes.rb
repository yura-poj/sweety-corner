Rails.application.routes.draw do
  root "categories#index"
  get 'products', to: redirect('/products/page/1')

  resources :products, only: [:show, :create, :update, :destroy, :new, :edit ] do
    get "page/:page", action: :index, on: :collection
  end

  resources :categories, only: [ :index, :show, :create, :update, :destroy, :new, :edit ]

  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check
end
