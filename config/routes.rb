Rails.application.routes.draw do
  get "/register", to: "users#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :items
  resources :cart do
    member do
      delete :remove_item
    end
  end
  resources :categories
  resources :orders_items
  root "welcome#index"

  resources :users do
    resources :orders
  end
  namespace :admin do
    resources :categories
    resources :dashboard
    resources :items
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
