Rails.application.routes.draw do
    post '/login', to: "sessions#create"

    resources :user

    root 'welcome#index'

end
