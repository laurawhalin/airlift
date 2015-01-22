Rails.application.routes.draw do
  resources :categories
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  root "welcome#index"
  resources :items

end
