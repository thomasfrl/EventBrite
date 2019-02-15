Rails.application.routes.draw do

  root to: 'events#index'
  devise_for :users
  resources :events do
    resources :attendances, only: [:new, :create, :index]
  end
  resources :users, only: [:show] do
    resources :avatars, only: [:create]
  end

  namespace :admin do
    root to: "users#index"
    resources :users
    resources :events
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
