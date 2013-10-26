Box::Application.routes.draw do
  devise_for :users, path: '', path_names: { :sign_in => 'login', :sign_out => 'logout', :sign_up => 'register' }

  root to: "users#index"

  namespace :api do
    namespace :v1 do
      resources :folders, only: [:show]
    end
  end

  resources :users, only: [:show]
end
