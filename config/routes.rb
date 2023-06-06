Rails.application.routes.draw do
  root 'page#index'

  devise_for :users, skip: :all
  devise_scope :user do
    get 'login', to: 'users/sessions#new', as: :new_user_session
    post 'login', to: 'users/sessions#create', as: :user_session
    delete 'logout', to: 'users/sessions#destroy', as: :destroy_user_session
    get 'signup', to: 'users/registrations#new', as: :new_user_registration
    post 'signup', to: 'users/registrations#create', as: :user_registration
    get 'signup/cancel', to: 'users/registrations#cancel', as: :cancel_user_registration
    get 'user', to: 'users/registrations#edit', as: :edit_user_registration
    patch 'user', to: 'users/registrations#update', as: :update_user_registration
    delete 'user', to: 'users/registrations#destroy', as: :destroy_user_registration
    get 'user/password', to: 'users/passwords#new', as: :new_user_password
    post 'user/password', to: 'users/passwords#create', as: :user_password
    get 'user/password/edit', to: 'users/passwords#edit', as: :edit_user_password
    patch 'user/password', to: 'users/passwords#update', as: :update_user_password
  end
  devise_for :users, only: [:confirmations]
  resources :users, except: [:index, :new], param: :account_name do
    resources :relationships, only: [:create, :destroy]
    get 'followers', to: 'relationships#followers'
    get 'following', to: 'relationships#following'
    resources :advrials, only: [:index]
    resources :places
  end
  resources :advrials, except: [:index] do
    resource :advrial_places
  end
  
  get "search/users", to: "search#user"
  get "results/users", to: "search#result_users"
  get "search/advrials", to: "search#advrial"
  get "results/advrials", to: "search#result_advrials"
  

  get 'welcome', to: 'users#welcome'
end
