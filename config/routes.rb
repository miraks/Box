Box::Application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  root to: "users#index"

  namespace :api do
    namespace :v1 do
      resources :folders, only: [:show, :update]
      resources :uploads, only: [:create, :update] do
        get :download
        collection do
          patch :move, :copy
        end
      end
      resources :users, only: [] do
        scope module: :users do
          resources :messages, only: [:index, :show, :create]
          resource :friendships, only: [:create, :destroy]
          collection do
            resources :friends, only: [:index]
          end
        end
      end
    end
  end

  resources :users, only: [:show, :index] do
    scope module: :users do
      resources :purchases, only: [:index]
      resources :messages, only: [:index, :show]
    end
  end
end
