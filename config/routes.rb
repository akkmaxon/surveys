Rails.application.routes.draw do
  namespace :admins do
    resources :coordinators, only: [:index, :show, :create, :update, :destroy]
    resources :users, only: [:index, :show, :create, :update]
    resources :companies, only: [:index, :create, :update, :destroy]
    resources :questions, only: [:index, :create, :update, :destroy]
    get 'search' => 'search#search'
    post 'application/clean_person_credentials'
    root to: 'application#index'
  end
  devise_for :admins, path_names: {
    sign_in: 'login'
  }

  namespace :coordinators do
    resources :surveys, only: [:index, :show] do
      collection do
	get 'export'
      end
    end
    resources :users, only: [:index]
    get 'search' => 'search#search'
    root to: 'application#index'
  end
  devise_for :coordinators, path_names: {
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

  get 'application/update_csv'
  root to: 'home#about'
end
