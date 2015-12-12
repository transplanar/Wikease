Rails.application.routes.draw do
  get 'users/new'

  get 'users/show'

  get 'users/index'

  get 'user/new'

  get 'user/index'

  get 'user/show'

  get 'user/create'

  get 'user/destroy'

  resources :wikis

  devise_for :users

  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'
end
