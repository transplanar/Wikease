Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show, :index]
  resources :wikis
  # resources :welcome, only: [:index, :about]

  root 'welcome#index'

  # get 'users/new'

  # get 'users/show'

  # get 'users/index'

  # get 'user/new'

  # get 'user/index'

  # get 'user/show'

  # get 'user/create'

  # get 'user/destroy'

  get 'welcome/index'

  get 'welcome/about'
end
