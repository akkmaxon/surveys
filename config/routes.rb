Rails.application.routes.draw do
  resources :surveys
  devise_for :users
  root to: 'surveys#index'
end
