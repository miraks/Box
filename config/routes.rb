Box::Application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  root to: "users#index"

  concern :permissions do
    resources :permissions, only: [:index, :create, :destroy] do
      collection do
        get :check
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :folders, only: [:show, :update] do
        scope module: :folders do
          concerns :permissions
        end
      end
      resources :uploads, only: [:create, :update] do
        get :download
        collection do
          patch :move, :copy
        end
        scope module: :uploads do
          concerns :permissions
        end
      end
      resources :users, only: [] do
        scope module: :users do
          resources :conversations, only: [:index, :show, :create]
          resources :messages, only: [:create, :destroy]
          resource :friendships, only: [:create, :destroy]
          collection do
            resources :friends, only: [:index] do
              collection do
                get :online
              end
            end
            resources :search, only: [:index]
          end
        end
      end
      namespace :administration do
        resources :extension_icons, only: [:index, :create, :destroy]
      end
    end
  end

  resources :users, only: [:show, :index] do
    scope module: :users do
      resources :purchases, only: [:index]
      resources :conversations, only: [:index, :show]
    end
  end

  resource :administration, only: [:show] do
    collection do
      get :extension_icons
    end
  end
end
