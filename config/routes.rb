Rails.application.routes.draw do
  root "welcome#index"
  get "/not_found", to: "welcome#not_found"
  get "/register", to: "users#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :items
  resources :cart
  resources :categories, only: [:show]
  resources :orders_items

  resources :users do
    resources :orders
  end

  namespace :admin do
    resources :categories
    resources :items
    resources :orders
  end

  resources :suppliers, path: "", param: :slug
  namespace :suppliers, as: :supplier, path: "/:slug" do
    resources :categories
    resources :items
    resources :orders
		resources :users
  end
end
