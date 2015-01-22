Rails.application.routes.draw do
  get "/register", to: "users#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, :items, :cart_items
  root "welcome#index"
end
