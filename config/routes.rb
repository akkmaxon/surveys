Rails.application.routes.draw do
  namespace :admin do
    resources :users, except: [:destroy, :edit]
    root to: 'application#index'
  end

  devise_for :admin, path_names: {
    sign_in: 'login'
  }

  resource :responses, only: [:create]
  resource :info, only: [:new, :create, :edit, :update]
  resources :surveys, only: [:index, :show, :create, :update] do
    member do
      get 'take'
    end
  end

  devise_for :users, only: [:sessions]
  devise_scope :user do
    get 'login' => 'devise/sessions#new'
  end

  root to: 'home#about'
end
