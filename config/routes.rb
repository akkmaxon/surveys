Rails.application.routes.draw do
  namespace :admin do
    get 'application/index'
  end

  resource :responses, only: [:create]
  resource :info, only: [:new, :create, :edit, :update]
  resources :surveys, only: [:index, :show, :create, :update] do
    member do
      get 'take'
    end
  end

  devise_for :users

  devise_for :admins
  namespace :admin do
    root to: 'application#index'
  end

  root to: 'home#about'
end
