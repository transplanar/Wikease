Rails.application.routes.draw do
  get 'charges/create'

  devise_for :users

  resources :users, only: [:show, :index]
  # TODO cleanup extraneous paths
  resources :wikis
  # resources :charges, only: [:new, :create]
  resources :charges, only: [:new, :create, :edit]

  root 'welcome#index'

  get 'welcome/index'

  get 'welcome/about'
end
