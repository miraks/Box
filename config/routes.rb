Box::Application.routes.draw do
  devise_for :users

  root to: "users#index"

  namespace :api do
    namespace :v1 do
      resources :folders, only: [:show]
      resources :uploads, only: [:create]
    end
  end

  resources :users, only: [:show]
end
