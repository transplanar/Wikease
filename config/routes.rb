Rails.application.routes.draw do
  resources :collaborations
  get 'charges/create'

  devise_for :users

  resources :users, only: [:show, :index]
  get 'controller/downgrade' => 'users#downgrade', as: :downgrade_user


  resources :wikis do
    resources :collaborations, only: [:index, :create, :destroy]
  end

  resources :charges, only: [:new, :create]

  root 'welcome#index'

  get 'welcome/index'

  get 'welcome/about'
end
