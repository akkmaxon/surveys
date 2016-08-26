Rails.application.routes.draw do
  resource :responses, only: [:create]
  resource :info, only: [:new, :create, :edit, :update]
  resources :surveys, only: [:index, :show, :create, :update] do
    member do
      get 'take'
    end
  end
  devise_for :users
  root to: 'surveys#index'
end
