Rails.application.routes.draw do
  resources :items, only: [:index, :create, :edit, :update, :destroy]

  get '/search' => 'items#search'
  root 'items#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users do
  end
end
