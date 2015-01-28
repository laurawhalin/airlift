Rails.application.routes.draw do
  get "/register", to: "users#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :items
  resources :cart

  # get "/cart", to: "cart#show", as: "cart"
  resources :categories
  resources :orders_items
  root "welcome#index"

  resources :users do
    resources :orders
  end

  namespace :admin do
    resources :categories
    resources :items
    resources :orders
  end

  # resources :users, only: [:show, :edit, :update] do
  #   member do
  #     resources :orders, only: [:index, :show, :create, :new]
  #   end
  # end
  #
  # namespace :admin do
  #   resources :categories
  # end

end
