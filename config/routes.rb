Rails.application.routes.draw do
  namespace :admin do
    resources :coordinators, only: [:index, :show, :create, :update, :destroy]
    resources :users, only: [:index, :show, :create, :update]
    resources :companies, only: [:index, :create, :update, :destroy]
    resources :questions, only: [:index, :create, :update, :destroy]
    get 'search' => 'search#search'
    post 'application/clean_person_credentials'
    root to: 'application#index'
  end
  devise_for :admin, path_names: {
    sign_in: 'login'
  }

  namespace :coordinator do
    resources :surveys, only: [:index] do
      collection do
	get 'export'
      end
    end
    resources :users, only: [:index] do
      resources :surveys, only: [:index, :show], controller: 'users/surveys'
    end
    get 'search' => 'search#search'
    root to: 'application#index'
  end
  devise_for :coordinator, path_names: {
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
