Rails.application.routes.draw do
  root to: redirect('/products/page/1')

  resources :products, only: [:show, :create, :update, :destroy] do
    get 'page/:page', action: :index, on: :collection
  end

  resources :category, only: [:index, :show, :create, :update, :destroy]

  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

end
