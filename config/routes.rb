Box::Application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  root to: "users#index"

  concern :lockable do
    get :permission
  end

  namespace :api do
    namespace :v1 do
      resources :folders, only: [:show, :update], concerns: [:lockable]
      resources :uploads, only: [:create, :update], concerns: [:lockable] do
        get :download
        collection do
          patch :move, :copy
        end
      end
      resources :users, only: [] do
        scope module: :users do
          resources :conversations, only: [:index, :show, :create]
          resources :messages, only: [:create]
          resource :friendships, only: [:create, :destroy]
          collection do
            resources :friends, only: [:index]
            resources :search, only: [:index]
          end
        end
      end
    end
  end

  resources :users, only: [:show, :index] do
    scope module: :users do
      resources :purchases, only: [:index]
      resources :conversations, only: [:index, :show]
    end
  end
end
