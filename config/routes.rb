Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]

    collection do
      get :feeds
    end
    member do
      get :dashboard
    end
  end
  resources :categories, only: :show
  resources :users, only: [:show, :edit, :update]
  namespace :admin do
    resources :restaurants
    resources :categories
  end
  root "restaurants#index"
end
