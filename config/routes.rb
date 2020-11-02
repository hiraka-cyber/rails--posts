Rails.application.routes.draw do
  devise_for :users
  root 'tweets#index'
  resources :tweets do
    resources :comments
    resources :likes
  end
  resources :users do
    member do
     get :following, :followers
    end
  end
  resources :relationships
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
